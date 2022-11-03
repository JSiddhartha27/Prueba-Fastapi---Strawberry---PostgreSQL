from datetime import datetime
import asyncpg
import databases
import strawberry
from fastapi import FastAPI
from strawberry.fastapi import GraphQLRouter
from typing import List

DATABASE_URL ="postgresql://postgres:juan1@localhost/publication" #Linea 10 y 12 así se crea la conexión con la base de datos.

database = databases.Database(DATABASE_URL)


@strawberry.input
class PostsInput:
    id_post: int
    descripcion: str
    video_url: str
    created_at: datetime


@strawberry.input
class CommentsInput:
    id_comm: int
    description: str
    created_at: datetime
    post_id: int




@strawberry.type
class Posts:
    id_post: int
    descripcion: str
    video_url:str
    created_at: datetime




@strawberry.type
class Comments:
    id_comm: int
    description: str
    created_at: datetime
    post_id: int



async def read_posts() -> List[Posts]:
    query = " SELECT * FROM posts"
    rows = await database.fetch_all(query)

    return [Posts(id_post=r.id_post, descripcion=r.descripcion, video_url=r.video_url,created_at=r.created_at) for r in rows] 




async def read_comments() -> List[Comments]:
    query = " SELECT * FROM comments"
    rows = await database.fetch_all(query)

    return [Comments(id_comm=r.id_comm, description=r.description, created_at=r.created_at, post_id=r.post_id) for r in rows]



async def read_for_idpost(id_post:int) -> Posts:
    query = "SELECT * FROM posts WHERE id_post=%s"%id_post
    rows = await database.fetch_one(query)

    return  Posts(id_post=rows.id_post, descripcion=rows.descripcion, video_url=rows.video_url, created_at=rows.created_at)



async def read_for_idcomm(id_comm:int) -> Comments:
    query = "SELECT * FROM comments WHERE id_comm=%s"%id_comm
    rows = await database.fetch_one(query)

    return Comments(id_comm=rows.id_comm, description=rows.description, created_at=rows.created_at, post_id=rows.post_id)
  

@strawberry.type
class Query:
    posts: List[Posts] = strawberry.field(resolver=read_posts) 
    
    comments: List[Comments] = strawberry.field(resolver=read_comments) 

    readpost: Posts = strawberry.field(resolver=read_for_idpost)

    readcomm: Comments = strawberry.field(resolver=read_for_idcomm)






@strawberry.type
class Mutation:
    @strawberry.mutation
    async def create_post(self, data: PostsInput) -> Posts:
        row = await database.fetch_one("INSERT INTO posts(id_post, descripcion, video_url, created_at) values (:id_post, :descripcion, :video_url, :created_at) returning *",
                                        values={"id_post": data.id_post, "descripcion": data.descripcion, "video_url": data.video_url, "created_at": data.created_at})
        return Posts(id_post=row.id_post, descripcion=row.descripcion, video_url=row.video_url, created_at=row.created_at)





@strawberry.type
class Mutation:
    @strawberry.mutation
    async def create_comments(self, data: CommentsInput) -> Comments:
        row = await database.fetch_one("INSERT INTO comments(id_comm, description, created_at, post_id) values (:id_comm, :description, :created_at, :post_id) returning *",
                                        values={"id_comm": data.id_comm, "description": data.description, "created_at": data.created_at, "post_id": data.post_id})
        return Comments(id_comm=row.id_comm, description=row.description, created_at=row.created_at, post_id=row.post_id)






schema= strawberry.Schema(Query,Mutation)


graphql_app = GraphQLRouter(schema)


app = FastAPI()

app.include_router(graphql_app, prefix="/graphql")

@app.on_event("startup")
async def startup():
    await database.connect()


@app.on_event("shutdown")
async def shutdown():
    await database.disconnect()
