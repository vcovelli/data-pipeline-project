from prefect import task, flow

@task
def extract_data():
    print("Extracting data...")
    data = [{"name": "Alice", "age": 25}, {"name": "Bob", "age": 30}]
    return data

@task
def transform_data(data):
    print("Transforming data...")
    transformed_data = [{"name": person["name"], "age": person["age"] * 2} for person in data]
    return transformed_data

@task
def load_data(data):
    print("Loading data into destination...")
    print(f"Data loaded: {data}")
    # Code to load data into your database or warehouse

@flow
def etl_data_pipeline():
    data = extract_data()
    transformed_data = transform_data(data)
    load_data(transformed_data)

if __name__ == "__main__":
    etl_data_pipeline()

