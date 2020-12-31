library(arules)
library(arulesViz)
library(readr)
# Read the csv file which has all the mrns and corresponding disease codes
dxCodeList <- read_csv("sepsis_data/dxCode.csv", col_names = TRUE)

# The file is in tbl format, converting into data frame
dxCodeList <- as.data.frame(dxCodeList)

# For analysis, since we need only the disease codes, subset the data by column to retain the disease codes only
diseaseCodes <- dxCodeList[,2]

# Save the file without any extentions. I observed that if you save it in a txt or csv format, the file is not
# read in a format required by read.transactions function. 
write(diseaseCodes, file = "diseaseCodes")

# Read the file as transactions data using the read.transactions function. Since the data is in a basket format
# i.e. not in a single format, which would have been just 2 cols with transaction id in one and item in 2nd.
# In this case we have list of transactions in each row. Also each item is comma separated so it is specified
# explicitly and we intend to skip the first row which is the column name of data.
diseaseCodes <- read.transactions("diseaseCodes", format = "basket", sep = ",", skip = 1)

size(head(diseaseCodes,5)) # number of items in each observation

inspect(head(diseaseCodes,2)) # Observe the items in the first few transactions

LIST(head(diseaseCodes, 3)) # convert 'transactions' to a list, note the LIST in CAPS

summary(diseaseCodes)

# -----------------------------------------------------------------------------------------------------------------
#                             How to see the most frequent items?
# -----------------------------------------------------------------------------------------------------------------

# maxlen limits the number of items in each frequent item set, minlen by default is 1 and if set then
# number of items will be in between min and max in each item set. Support is used specified. Eclat algorithm
# finds support for the frequent items.
frequentCodes <- eclat(diseaseCodes, parameter = list(supp = 0.3, minlen = 2, maxlen = 4)) 

# Visualize the frequent codes
plot(frequentCodes)

# Print frequent codes for specified support
inspect(frequentCodes)

# Plot frequent items
itemFrequencyPlot(diseaseCodes, topN=15, type="absolute", main="Disease Code Frequency Plot", xlab = "Disease Codes", 
                  ylab = "Count") 

# ------------------------------------------------------------------------------------------------------------------
#                           How to get the product recommendation rules?
#                           How To Control The Number Of Rules in Output ?
#                           
#                   1. To get 'strong' rules, increase the value of 'conf' parameter.
#                   2. To get 'longer' rules, increase 'maxlen'.
# ------------------------------------------------------------------------------------------------------------------

# maxlen = 4 limits the elements in a rule to 4 inlcuding both sides of arrow and minlen = 2 will prevent any rule
# with null lhs.
rules <- apriori(diseaseCodes, parameter = list(supp = 0.3, conf = 0.7, minlen = 2, maxlen=4)) 

rules_conf <- sort(rules, by="confidence", decreasing=TRUE) # 'high-confidence' rules.

inspect(head(rules_conf)) # show the support, lift and confidence for all rules

rules_lift <- sort(rules, by="lift", decreasing=TRUE) # 'high-lift' rules.

inspect(head(rules_lift)) # show the support, lift and confidence for all rules

plot(rules,method ="graph" )
# --------------------------------------------------------------------------------------------------------------------
#                           How To Remove Redundant Rules ? 
#              Sometimes it is desirable to remove the rules that are subset of larger rules.
# --------------------------------------------------------------------------------------------------------------------

subsetRules <- which(colSums(is.subset(rules, rules)) > 1) # get subset rules in vector

length(subsetRules) 

rules <- rules[-subsetRules] # remove subset rules. 

# --------------------------------------------------------------------------------------------------------------------
#                           How to Find Rules Related To Given Disease Code ?
#              This can be achieved by modifying the appearance parameter in the apriori() function.
# --------------------------------------------------------------------------------------------------------------------

# To find what factors influenced the occurence of Disease X

# To find out what diseases occured before occurence of 'EP751'. 
# This will help understand the patterns that led to the occurence of 'EP751'.

# get rules that lead to buying 'EP751'
rules <- apriori(data=diseaseCodes, parameter=list (supp = 0.1, conf = 0.3), 
                 appearance = list(default="lhs",rhs="785.52"), control = list (verbose=F)) 


rules_conf <- sort(rules, by="confidence", decreasing=TRUE) # 'high-confidence' rules.

inspectDT(head(rules_conf))

itemsets <- eclat(diseaseCodes, parameter = list(support = 0.1, minlen=4))

plot(itemsets, method="graph")

