# EM622---5

FIFA is a series of video games developed by EA Sports which faithfully reproduces the characteristics of real players. FIFA ratings of football players from the video game for 2019 can be found in the dataset fifa2019.csv. The dataset contains players attributes like Age, Nationality, Overall, Potential, Club, Value, Wage, Preferred Foot, International Reputation, etc. More information about the attributes and dataset can be found at https://sofifa.com/ and https://www.kaggle.com/karangadiya/fifa19.

(1) Download “fifa2019.csv”. Spend some time understanding the dataset and perform necessary data cleaning.

(2) Make a meaningful subset of the data. Identify at least three variables of interest and explore relationship between these variables using the plot(s) of your choice. Elaborate on the reason of choosing the plot(s), and findings.
To deal with special characters, use function strsplit:
fifa2019$HeightInch <- sapply(strsplit(fifa2019$Height, split = "'", fixed = T), function(x) sum(as.numeric(x)*c(12, 1)))

See lines 28-82

Compare agility and strength of lean players over 30 with agility and strength of lean players under 30. This chart sheds light on the relationship between age, agility, and strength
The box plots reveal that strength is overall greater for the players over 30 than the players under 25. The red dot on the plots indicate the mean strength value. They also reveal that there is very small difference in agility between the two age groups, with players over 30 overall having greater agility. The box plots were the best choice to show these summary statistics for this dataset.

(3) Identify at least five different variables and visualize all variables using the plot(s) of your choice (e.g., scatter plot, bar plot, table heat map, Chernoff faces, etc.).

See lines 88-167

Of those with sprint speed of at least 85, what is the percentage breakdown of body types? This chart covers two variables: Sprint Speed and Body Type and clearly shows lean and normal body types as the predominant body types of fast sprinters.

What is the percentage breakdown of preferred foot for goalkeepers? This chart covers two variables: Position and Preferred Foot and clearly shows that by a 90-10 margin goalkeepers have a right preferred foot.

Considering players worth at least 1M, who is worth more overall, strikers or wingers? This plot covers two variables: Position and value and shows that wingers are paid slightly more than strikers. The box plot in this example shows the summary statistics for each position’s value.

(4) Create an interactive world map that shows two summary statistics of each country.
See lines 173-186

Using any dataset that has been introduced in another project, propose a question, and create an interactive plot of your choice to answer it. Elaborate on the findings. Include labels and tune the appearance.
See lines 192-199

This chart serves to expand on Project 2’s California Monthly Rainfall in 1950 plot, and adds interactive functionality.


