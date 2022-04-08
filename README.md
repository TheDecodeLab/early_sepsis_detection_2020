# early_sepsis_detection_2020

This folder contains meta-data and exploratory analysis part of the article entitled **“Early Detection of Septic Shock Onset Using Interpretable Machine Learners”** by *Debdipto Misra, Venkatesh Avula, Donna M. Wolk, Hosam A. Farag, Jiang Li, Yatin B. Mehta, Ranjeet Sandhu, Bipin Karunakaran, Shravan Kethireddy, Ramin Zand* and *Vida Abedi*.

Summary: Clinical data from Electronic Health Record (EHR), at encounter level, were used to build a predictive model for progression from sepsis to septic shock up to 6 hours from the time of admission; that is, T=1, 3, and 6 hours from admission. Eight different machine learning algorithms (Random Forest, XGBoost, C5.0, Decision Trees, Boosted Logistic Regression, Support Vector Machine, Logistic Regression, Regularized Logistic, Bayes Generalized Linear Model) were used for model development. Two adaptive sampling strategies were used to address the class imbalance. Data from two sources (clinical and billing codes) were used to define the case definition (septic shock) using the Centers for Medicare & Medicaid Services (CMS) Sepsis criteria. The model assessment was performed using Area Under Receiving Operator Characteristics (AUROC), sensitivity, and specificity. Model predictions for each feature window (1,3 and 6 hours from admission) were consolidated. 

# Publication
[Early Detection of Septic Shock Onset Using Interpretable Machine Learners](https://www.mdpi.com/2077-0383/10/2/301)
