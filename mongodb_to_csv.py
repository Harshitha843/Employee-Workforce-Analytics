from pymongo import MongoClient
import pandas as pd

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")

# Select database and collection
db = client["EmployeeWorkforceDB"]
collection = db["Employee_Feedback"]

# Get all documents from MongoDB
documents = list(collection.find({}, {"_id": 0}))

# Convert MongoDB documents to DataFrame
df = pd.DataFrame(documents)

# Export to CSV
df.to_csv("employee_feedback.csv", index=False)

print("MongoDB data exported successfully!")
print(f"Total records exported: {len(df)}")
print("File created: employee_feedback.csv")

# Close connection
client.close()