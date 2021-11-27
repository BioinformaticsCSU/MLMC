# MLMC

## Drug repositioning based on multi-view learning with matrix completion.

In this article, we propose a multi-view learning with matrix completion (MLMC) method to predict the potential associations between drugs and diseases. Specifically, MLMC first learns the comprehensive similarity matrices from five drug similarity matrices and two disease similarity matrices based on the multi-view learning (ML) with Laplacian graph regularization, and updates the drug-disease association matrix simultaneously. Then, we introduce matrix completion (MC) to add some positive entries in original association matrix based on low-rank structure, and re-execute the multi-view learning algorithm for association prediction. At last, the prediction results of the above two operations are integrated as the final output.

# Requirements

Matlab >= 2014
