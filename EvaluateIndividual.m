function fitness = EvaluateIndividual(chromosome,minChromosomeLength,maxChromosomeLength,lengthVariableRegisters,constantRegisters,penaltyFactor)
    
    data = LoadFunctionData;
    sumError = 0;
    

    for i = 1:size(data,1)

        x = data(i,1);
        y = data(i,2);

        estimatedFunctionValue = RunOperatorInstructions(chromosome,x,lengthVariableRegisters,constantRegisters);
        error = (y - estimatedFunctionValue)^2;
        sumError = sumError + error;
    end

    sumError = sqrt(sumError/i);
    fitness = 1/sumError;

        % penalty factor for chromosome exceeds max length
    if size(chromosome,2) > maxChromosomeLength
        fitness = fitness*penaltyFactor;
    end

end

