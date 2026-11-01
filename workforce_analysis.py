import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sqlalchemy import create_engine

# Connect to MySQL
engine = create_engine(
    "mysql+pymysql://root:AUG30_80HARSHI@localhost/EmployeeWorkforceDB"
)

# Load data from MySQL View
df = pd.read_sql(
    "SELECT * FROM Employee_Workforce_Analytics",
    engine
)

# 1. Dataset size
print("Dataset Shape:")
print(df.shape)

# 2. First 5 records
print("\nFirst 5 Records:")
print(df.head())

# 3. Last 5 records
print("\nLast 5 Records:")
print(df.tail())

# 4. Column names
print("\nColumn Names:")
print(df.columns.tolist())

# 5. Data types and non-null values
print("\nDataset Information:")
df.info()

# 6. Statistical summary
print("\nStatistical Summary:")
print(df.describe())

# Check missing values
print("\n--- Missing Values ---")
print(df.isnull().sum())

# Check duplicate rows
print("\n--- Duplicate Rows ---")
print(df.duplicated().sum())

# Check data types
print("\n--- Data Types ---")
print(df.dtypes)

# Check unique values in important categorical columns
print("\n--- Employment Status ---")
print(df["Employment_Status"].value_counts())

print("\n--- Gender ---")
print(df["Gender"].value_counts())

print("\n--- Department ---")
print(df["Department_Name"].value_counts())

print("\n--- Overall Rating ---")
print(df["Overall_Rating"].value_counts())

df = df.drop_duplicates()
print("Rows after removing duplicates:", len(df))
print("\nMissing values before cleaning:")
print(df.isnull().sum())
numeric_columns = df.select_dtypes(include="number").columns

for column in numeric_columns:
    df[column] = df[column].fillna(df[column].median())

categorical_columns = df.select_dtypes(include="object").columns

for column in categorical_columns:
    df[column] = df[column].fillna("Unknown")
df["Review_Date"] = pd.to_datetime(df["Review_Date"])
print("\nFinal Dataset Shape:")
print(df.shape)

print("\nMissing Values After Cleaning:")
print(df.isnull().sum())

print("\nDuplicate Rows After Cleaning:")
print(df.duplicated().sum())

# Total number of employees
print("Total Employees:", df["Employee_ID"].nunique())

# Gender distribution
print("\nGender Distribution:")
print(df["Gender"].value_counts())

# Department-wise employee count
print("\nEmployees by Department:")
print(df["Department_Name"].value_counts())

# Employment status
print("\nEmployment Status:")
print(df["Employment_Status"].value_counts())

# Education level
print("\nEducation Level:")
print(df["Education_Level"].value_counts())

# salary analysis
print("Average Monthly Salary:",
      round(df["Monthly_Salary"].mean(), 2))

print("Minimum Monthly Salary:",
      round(df["Monthly_Salary"].min(), 2))

print("Maximum Monthly Salary:",
      round(df["Monthly_Salary"].max(), 2))

print("Average Bonus:",
      round(df["Bonus"].mean(), 2))

print("\nDepartment-wise Average Salary:")
print(
    df.groupby("Department_Name")["Monthly_Salary"]
      .mean()
      .round(2)
      .sort_values(ascending=False)
)

#performance analysis
print("Average Performance Score:",
      round(df["Performance_Score"].mean(), 2))

print("Average Productivity Score:",
      round(df["Productivity_Score"].mean(), 2))

print("Average Quality Score:",
      round(df["Quality_Score"].mean(), 2))

print("Average Teamwork Score:",
      round(df["Teamwork_Score"].mean(), 2))

print("\nOverall Rating Distribution:")
print(df["Overall_Rating"].value_counts())

print("\nDepartment-wise Performance:")
print(
    df.groupby("Department_Name")["Performance_Score"]
      .mean()
      .round(2)
      .sort_values(ascending=False)
)

#Attendance
print("Average Attendance Percentage:",
      round(df["Attendance_Percentage"].mean(), 2))

print("Average Work Hours:",
      round(df["Average_Work_Hours"].mean(), 2))

print("\nAttendance Status:")
print(
    df[["Present_Days", "Absent_Days", "Leave_Days"]].sum()
)

print("\nDepartment-wise Attendance:")
print(
    df.groupby("Department_Name")["Attendance_Percentage"]
      .mean()
      .round(2)
      .sort_values(ascending=False)
)

print("Correlation between Salary and Performance:",
      round(df["Monthly_Salary"].corr(df["Performance_Score"]), 2))

print("Correlation between Attendance and Performance:",
      round(df["Attendance_Percentage"].corr(df["Performance_Score"]), 2))

print("Correlation between Experience and Salary:",
      round(df["Experience_Years"].corr(df["Monthly_Salary"]), 2))

print("Correlation between Experience and Performance:",
      round(df["Experience_Years"].corr(df["Performance_Score"]), 2))

# Employee by department - Bar chart
plt.figure(figsize=(10, 6))

df["Department_Name"].value_counts().plot(kind="bar")

plt.title("Number of Employees by Department")
plt.xlabel("Department")
plt.ylabel("Number of Employees")
plt.xticks(rotation=45, ha="right")
plt.tight_layout()
plt.show()

#Gender distribution - Pie chart
plt.figure(figsize=(7, 7))

df["Gender"].value_counts().plot(
    kind="pie",
    autopct="%1.1f%%"
)

plt.title("Gender Distribution")
plt.ylabel("")
plt.show()
#salary distribution - Histogram
plt.figure(figsize=(10, 6))

plt.hist(df["Monthly_Salary"], bins=20)

plt.title("Monthly Salary Distribution")
plt.xlabel("Monthly Salary")
plt.ylabel("Number of Employees")
plt.tight_layout()
plt.show()

#performance score distribution - histogram
plt.figure(figsize=(10, 6))

plt.hist(df["Performance_Score"], bins=15)

plt.title("Performance Score Distribution")
plt.xlabel("Performance Score")
plt.ylabel("Number of Employees")
plt.tight_layout()
plt.show()
#Overall rating distribution - Count plot
plt.figure(figsize=(8, 5))

sns.countplot(
    data=df,
    x="Overall_Rating"
)

plt.title("Overall Performance Rating")
plt.xlabel("Rating")
plt.ylabel("Number of Employees")
plt.xticks(rotation=20)
plt.tight_layout()
plt.show()

#Department vs performance

department_performance = (
    df.groupby("Department_Name")["Performance_Score"]
    .mean()
    .sort_values(ascending=False)
)


plt.figure(figsize=(10, 6))

department_performance.plot(kind="bar")

plt.title("Average Performance Score by Department")
plt.xlabel("Department")
plt.ylabel("Average Performance Score")
plt.xticks(rotation=45, ha="right")
plt.tight_layout()
plt.show()
#Attendance distribution - Box plot
plt.figure(figsize=(8, 5))

sns.boxplot(
    y=df["Attendance_Percentage"]
)

plt.title("Attendance Percentage Distribution")
plt.ylabel("Attendance Percentage")
plt.tight_layout()
plt.show()

#salary vs performance - Scatter plot
plt.figure(figsize=(10, 6))

plt.scatter(
    df["Monthly_Salary"],
    df["Performance_Score"]
)

plt.title("Salary vs Performance")
plt.xlabel("Monthly Salary")
plt.ylabel("Performance Score")
plt.tight_layout()
plt.show()

#Attendance vs performance - Scatter plot
plt.figure(figsize=(10, 6))

plt.scatter(
    df["Attendance_Percentage"],
    df["Performance_Score"]
)

plt.title("Attendance vs Performance")
plt.xlabel("Attendance Percentage")
plt.ylabel("Performance Score")
plt.tight_layout()
plt.show()

#correlation heatmap

numeric_columns = [
    "Experience_Years",
    "Monthly_Salary",
    "Bonus",
    "Performance_Score",
    "Productivity_Score",
    "Quality_Score",
    "Teamwork_Score",
    "Attendance_Percentage",
    "Average_Work_Hours"
]

correlation = df[numeric_columns].corr()

plt.figure(figsize=(12, 8))

sns.heatmap(
    correlation,
    annot=True,
    fmt=".2f"
)

plt.title("Correlation Heatmap")
plt.tight_layout()
plt.show()

df.to_csv("employee_workforce_cleaned.csv", index=False)

print("\nCleaned dataset saved successfully!")
print("File: employee_workforce_cleaned.csv")


from pymongo import MongoClient

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")

# Select database
db = client["EmployeeWorkforceDB"]

# Select collection
collection = db["Employee_Feedback"]

print("\nConnected to MongoDB successfully!")

# Create performance review documents from existing DataFrame
review_data = df[
    [
        "Employee_ID",
        "Review_Date",
        "Performance_Score",
        "Productivity_Score",
        "Quality_Score",
        "Teamwork_Score",
        "Overall_Rating"
    ]
].copy()

# Convert date to string for MongoDB
review_data["Review_Date"] = review_data["Review_Date"].astype(str)

# Convert DataFrame to dictionary
records = review_data.to_dict("records")

# Insert records into MongoDB
if records:
    collection.insert_many(records)

print(f"{len(records)} performance review records inserted into MongoDB.")

# Close MongoDB connection
client.close()

print("MongoDB connection closed.")