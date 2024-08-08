import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

df = pd.read_csv("C:/Users/taya/Downloads/python stuff/top_paying_job_skill_1 (practice).csv")
df_2 = pd.read_csv("C:/Users/taya/Downloads/python stuff/top_paying_job_1.csv")

# Setting column type for df
df['job_id'] = df['job_id'].astype('category')
df['job_title'] = df['job_title'].astype('str')
df['job_location'] = df['job_location'].astype('category')
df['job_schedule_type'] = df['job_schedule_type'].astype('category')
df['skills'] = df['skills'].astype('category')
df['salary_year_avg'] = df['salary_year_avg'].astype('float').round(2)
df['job_posted_date'] = df['job_posted_date'].astype('category')
df.info()

# Setting column type for df_2
df_2['job_id'] = df_2['job_id'].astype('category')
df_2['job_title'] = df_2['job_title'].astype('str')
df_2['job_schedule_type'] = df_2['job_schedule_type'].astype('category')
df_2['salary_year_avg'] = df_2['salary_year_avg'].astype('float').round(2)
df_2['company_name'] = df_2['company_name'].astype('category')
df_2['job_posted_date'] = df_2['job_posted_date'].astype('category')
df_2.info()

# Count occurrences of each skill
skill_counts = df.dropna(subset='skills')['skills'].value_counts()
def format_autopct(pct):
    return ('%.2f%%' % pct) if pct > 4 else ''

# Custom function to format the category labels
def format_category_labels(counts, labels):
    total = sum(counts)
    new_labels = []
    for count, label in zip(counts, labels):
        pct = 100 * count / total
        new_labels.append(label if pct >= 4 else '')
    return new_labels

# Format the labels
labels = format_category_labels(skill_counts, skill_counts.index)

# Plot pie chart
plt.figure(figsize=(8, 8))
wedges, texts, autotexts = plt.pie(skill_counts, labels=labels, autopct=format_autopct, startangle=140, pctdistance=0.85)
plt.legend(wedges, skill_counts.index, title="Skills", loc="center left", bbox_to_anchor=(1, 0, 0.5, 1))
plt.title('Skill Distribution')
plt.show()

# Group by 'job_id' and calculate the mean of 'salary_year_avg' 
grouped_df = df.dropna(subset='skills')[['skills', 'salary_year_avg']].groupby('skills').mean().sort_values('salary_year_avg')

colors = plt.cm.get_cmap('prism', len(df['skills']))
# Create a modified version of the colors with reduced vibrancy
reduced_vibrancy_colors = []
for r, g, b, _ in [colors(i) for i in range(len(df['skills']))] :
    reduced_vibrancy_colors.append((r*0.85, g*0.85, b*0.85, 0.9))

# Create y-ticks
salary_ticks = list(range(0,300000,50000))    
# Plotting the bar chart
plt.bar(grouped_df.index.astype(str), grouped_df['salary_year_avg'].astype(float), color = reduced_vibrancy_colors)
plt.xlabel('skills')
plt.ylabel('Average Salary (Yearly)')
plt.title('Average Yearly Salary by skills')
plt.xticks(rotation = 90)  # Rotate x-axis labels if needed
plt.yticks(salary_ticks,[f'${x}' for x in salary_ticks])
plt.show()

# Plotting the top paying data analyst job
## Group by 'job_id' and calculate the mean of 'salary_year_avg' 
grouped_df_2 = df[['company_name', 'salary_year_avg']].groupby('company_name').mean().sort_values('salary_year_avg')

colors_2 = plt.cm.get_cmap('rainbow', len(df['company_name']))
## Create y-ticks
salary_ticks_2 = list(range(0,300000,50000))    
## Plotting the hbar chart
plt.figure(figsize = (8,8))
plt.barh(grouped_df_2.index.astype(str), grouped_df_2['salary_year_avg'].astype(float), color = [colors_2(i) for i in range(len(df['company_name']))])
plt.ylabel('Company Name')
plt.xlabel('Average Salary (Yearly)')
plt.title('Average Yearly Salary by Company')
plt.xticks(salary_ticks,[f'${x}' for x in salary_ticks_2])
plt.show()

# Plotting the top paying data analyst job
## Group by 'job_title' and calculate the mean of 'salary_year_avg' 
grouped_df_3 = df[['job_title', 'salary_year_avg']].groupby('job_title').mean().sort_values('salary_year_avg')

colors_3 = plt.cm.get_cmap('rainbow', len(df['job_title']))
## Create y-ticks
salary_ticks_3 = list(range(0,300000,50000))    
## Plotting the hbar chart
plt.figure(figsize = (8,8))
plt.barh(grouped_df_3.index.astype(str), grouped_df_3['salary_year_avg'].astype(float), color = [colors_3(i) for i in range(len(df['job_title']))])
plt.ylabel('Roles')
plt.xlabel('Average Salary (Yearly)')
plt.title('Average Yearly Salary by Roles')
plt.xticks(salary_ticks,[f'${x}' for x in salary_ticks_3])
plt.show()

