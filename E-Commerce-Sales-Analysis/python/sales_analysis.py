import pandas as pd

df = pd.read_csv("data/ecommerce_sales_raw.csv")

# First 5 rows
print(df.head())

# Number of rows and columns
print("Shape:", df.shape)

# Column information
print("\nDataset Information:")
df.info()

# Missing values
print("\nMissing Values:")
print(df.isnull().sum())

# Duplicate rows
print("\nDuplicate Rows:", df.duplicated().sum())
# -----------------------------
# DATA CLEANING
# -----------------------------

# Remove duplicate rows
df = df.drop_duplicates()

print("After removing duplicates:", df.shape)

# Fill missing customer names
df["Customer_Name"] = df["Customer_Name"].fillna("Unknown")

# Fill missing cities
df["City"] = df["City"].fillna("Unknown")

# Fill missing payment modes
df["Payment_Mode"] = df["Payment_Mode"].fillna("Unknown")

# Check missing values again
print("\nMissing Values After Cleaning:")
print(df.isnull().sum())

# Convert Order_Date to datetime
df["Order_Date"] = pd.to_datetime(df["Order_Date"])

# Check date range
print("\nDate Range:")
print("Start Date:", df["Order_Date"].min())
print("End Date:", df["Order_Date"].max())

# Basic business metrics
print("\n--- Business Metrics ---")

print("Total Orders:", df["Order_ID"].nunique())

print("Total Quantity Sold:", df["Quantity"].sum())

print("Total Sales:", df["Sales"].sum())

print("Total Profit:", df["Profit"].sum())

print("Average Order Value:", df["Sales"].mean())

# Sales by Category
category_sales = df.groupby("Category")["Sales"].sum().sort_values(ascending=False)

print("\nSales by Category:")
print(category_sales)

product_quantity = (
    df.groupby("Product")["Quantity"]
    .sum()
    .sort_values(ascending=False)
)

print("\nTop Products by Quantity Sold:")
print(product_quantity.head(10))

# Sales by Category
category_sales = df.groupby("Category")["Sales"].sum().sort_values(ascending=False)

print("\nSales by Category:")
print(category_sales)

# Profit by Category
category_profit = (
    df.groupby("Category")["Profit"]
    .sum()
    .sort_values(ascending=False)
)

print("\nProfit by Category:")
print(category_profit)


# Monthly Sales Analysis

df["Month"] = df["Order_Date"].dt.to_period("M")

monthly_sales = (
    df.groupby("Month")["Sales"]
    .sum()
    .sort_index()
)

print("\nMonthly Sales:")
print(monthly_sales)

import matplotlib.pyplot as plt

# Monthly Sales Trend
plt.figure(figsize=(10, 5))

plt.plot(
    monthly_sales.index.astype(str),
    monthly_sales.values,
    marker="o"
)

plt.title("Monthly Sales Trend")
plt.xlabel("Month")
plt.ylabel("Sales")
plt.xticks(rotation=45)

plt.tight_layout()
plt.show()

# Sales by State

state_sales = (
    df.groupby("State")["Sales"]
    .sum()
    .sort_values(ascending=False)
)

print("\nSales by State:")
print(state_sales)

# State-wise Sales Chart

plt.figure(figsize=(10, 6))

plt.bar(state_sales.index, state_sales.values)

plt.title("Sales by State")
plt.xlabel("State")
plt.ylabel("Total Sales")
plt.xticks(rotation=45)

plt.tight_layout()
plt.show()

# Sales by Payment Mode

payment_sales = (
    df.groupby("Payment_Mode")["Sales"]
    .sum()
    .sort_values(ascending=False)
)

print("\nSales by Payment Mode:")
print(payment_sales)

plt.figure(figsize=(9, 5))

plt.bar(payment_sales.index, payment_sales.values)

plt.title("Sales by Payment Mode")
plt.xlabel("Payment Mode")
plt.ylabel("Total Sales")
plt.xticks(rotation=30)

plt.tight_layout()
plt.show()

# Top 10 Customers by Sales

customer_sales = (
    df.groupby("Customer_Name")["Sales"]
    .sum()
    .sort_values(ascending=False)
)

print("\nTop 10 Customers by Sales:")
print(customer_sales.head(10))


# Sales vs Profit Analysis

plt.figure(figsize=(8, 5))

plt.scatter(df["Sales"], df["Profit"])

plt.title("Sales vs Profit")
plt.xlabel("Sales")
plt.ylabel("Profit")

plt.tight_layout()
plt.show()
correlation = df["Sales"].corr(df["Profit"])

print("\nSales-Profit Correlation:", correlation)

# Save cleaned dataset

df.to_csv("data/ecommerce_sales_cleaned.csv", index=False)

print("\nCleaned dataset saved successfully!")

