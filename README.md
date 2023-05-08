# -ParameterOptimization_WatercolumnModel
This procedure to process the parameter optimization of the water column ecological model.
For computational efficiency, the firsrt step is to filter the most sensitive parameters fro the key state variables of the model (in this case, 7 parameters are selected).
The second step is to divide each extracted parameter into several values within reasonal or empirical range, then input the parameter combinations into model and calculate the total variable coefficients (TCV) of the key state variables based on the idealized setting (which compiled from the HOT station data), and select the combinations that obtain the minimum TCV as the optimal parameters. 
