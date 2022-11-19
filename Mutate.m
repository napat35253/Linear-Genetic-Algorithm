function mutatedIndividual = Mutate(individual, mutationProbability,lengthConstantRegisters,lengthVariableRegisters,lengthOperators)
    nGenes = size(individual,2);
    mutatedIndividual = individual;
    lengthRegisters = lengthVariableRegisters + lengthConstantRegisters;
    for j = 1:nGenes
        r = rand;
        if (r < mutationProbability)
            modular = mod(j,4);
            switch modular
                case 1
                    mutatedIndividual(j) = fix(rand*lengthOperators+1);
                case 2
                    mutatedIndividual(j) = fix(rand*lengthVariableRegisters+1);
                case {3,0}
                    mutatedIndividual(j) = fix(rand*lengthRegisters+1);
                otherwise
                    disp('ERROR: instruction modulus has unexpected value');
            
            end
        end
    end
%     sprintf('Ind : %i || Mutated : %i',size(individual,2),size(mutatedIndividual,2))
end
