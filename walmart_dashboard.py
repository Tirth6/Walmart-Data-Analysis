import streamlit as st
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Load data
df = pd.read_csv('your_dataset.csv')  # replace with your file
df['Date'] = pd.to_datetime(df['Date'])
df['Month'] = df['Date'].dt.strftime('%b')
df['Time'] = pd.to_datetime(df['Time'])
df['Day'] = df['Date'].dt.day_name()
df['Hour'] = df['Time'].dt.hour

# Streamlit app
st.title("Walmart Sales Dashboard")

# Monthly Sales
st.subheader("Monthly Sales")
monthly_sales = df.groupby('Month')['Total'].sum().reset_index()
fig1, ax1 = plt.subplots()
sns.barplot(data=monthly_sales, x='Month', y='Total', ax=ax1)
st.pyplot(fig1)

# Sales by Gender
st.subheader("Gender-wise Sales Distribution")
gender_sales = df['Gender'].value_counts()
fig2, ax2 = plt.subplots()
gender_sales.plot.pie(autopct='%1.1f%%', ax=ax2)
ax2.set_ylabel('')
st.pyplot(fig2)

# Day-wise Sales
st.subheader("Sales by Day of the Week")
day_sales = df.groupby('Day')['Total'].sum().reset_index()
day_order = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday']
day_sales['Day'] = pd.Categorical(day_sales['Day'], categories=day_order, ordered=True)
day_sales = day_sales.sort_values('Day')
fig3, ax3 = plt.subplots()
sns.barplot(data=day_sales, x='Day', y='Total', ax=ax3)
st.pyplot(fig3)
