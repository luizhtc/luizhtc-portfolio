import os
from dotenv import load_dotenv
from pdf import daft_engine
from llama_index.core.tools import QueryEngineTool, ToolMetadata
from llama_index.core.agent import ReActAgent
from llama_index.llms.openai import OpenAI

load_dotenv()

tools = [
    QueryEngineTool(query_engine=daft_engine,
                    metadata=ToolMetadata(
                        name="daft_punk_data",
                        description="this gives detailed information about daft punk"
                    )
                )
]

llm = OpenAI(model="gpt-3.5-turbo-0125")
agent = ReActAgent.from_tools(tools, llm=llm, verbose=True, context="You are an agent specialized in Daft Punk, use only information from the daft_punk_data tool.")

while (prompt := input("Enter a prompt (q to quit): ")) != "q":
    result = agent.query(prompt)
    print(result)

