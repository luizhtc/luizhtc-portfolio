import os
from dotenv import load_dotenv
from llama_index.agent.openai import OpenAIAssistantAgent

load_dotenv()

agent = OpenAIAssistantAgent.from_new(
    name="Math Tutor",
    instructions="You are a personal math tutor. Write and run code to answer math questions.",
    openai_tools=[{"type": "code_interpreter"}],
    instructions_prefix="Please address the user as Jane Doe. The user has a premium account.",
    model="gpt-4o-2024-05-13"
)

response = agent.chat(
    "I need to solve the equation `3x + 11 = 14`. Can you help me?"
)

print(response)