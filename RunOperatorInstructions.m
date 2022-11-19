function estimatedFunctionValue = RunOperatorInstructions(chromosome,x,lengthVariableRegisters,constantRegisters)
    
    register = zeros(1,lengthVariableRegisters);
    register(1) = x;
    register = [register constantRegisters];

    for step = 1:4:size(chromosome,2)
        operator = chromosome(step);
        dest = chromosome(step+1);
        operand1 = chromosome(step+2);
        operand2 = chromosome(step+3);

        switch operator
            case 1
                register(dest) = register(operand1) + register(operand2);
                
            case 2
                register(dest) = register(operand1) - register(operand2);
            case 3
                register(dest) = register(operand1) * register(operand2);
            case 4
                if register(operand2)~=0
                    register(dest) = register(operand1) / register(operand2);
                else 
                    register(dest) = 0;
                end
        end
    end
    estimatedFunctionValue = register(1);
end

