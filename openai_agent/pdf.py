import os

from llama_index.core import (
    StorageContext,
    VectorStoreIndex,
    load_index_from_storage
)

from llama_index.core import SimpleDirectoryReader

def get_index(data_path, index_name):
    index = None
    if not os.path.exists(index_name):
        print("building index", index_name)

        reader = SimpleDirectoryReader(
            input_files=[data_path]
        )

        docs = reader.load_data()
        print(f"Loaded {len(docs)} docs")

        index = VectorStoreIndex.from_documents(docs, show_progress=True)
        index.storage_context.persist(persist_dir=index_name)
    else:
        print("index already exists", index_name)
        index = load_index_from_storage(
            StorageContext.from_defaults(persist_dir=index_name)
        )

    return index


pdf_path = os.path.join(".data","Daft Punk.pdf")

daft_index = get_index(pdf_path, "daft_punk")
daft_engine = daft_index.as_query_engine()