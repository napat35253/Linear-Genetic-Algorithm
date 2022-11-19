chromosome = BestChromosome;

constantRegisters = [1 2 3 7 pi exp(1)];
operators = [1 2 3 4]; % [+,-,*,/]
lengthVariableRegisters = 4;
lengthConstantRegisters = size(constantRegisters,2);
lengthOperators = size(operators,2);

data = LoadFunctionData;
resultArray = [];
errorSum = 0;

for i = 1:size(data,1)
    estimatedValue = RunOperatorInstructions(chromosome,data(i,1),lengthVariableRegisters,constantRegisters);
    resultArray = [resultArray estimatedValue];
    error = (estimatedValue - data(i,2))^2;
    errorSum = error + errorSum;
end

fitness = 1/(sqrt(errorSum/i));
plot(data(:,1),data(:,2),'r--',data(:,1),resultArray,'b-');
legend("Real function","Estimated function")
xlabel('x')
ylabel('f(x)')
sprintf('Error : %0.5f Fitness : %0.5f ',sqrt(errorSum/i),fitness)