function population = InitializePopulation(populationSize,maxChromosomeLength,minChromosomeLength,lengthConstantRegisters,lengthVariableRegisters,lengthOperators)

population = [];
for i = 1:populationSize
    
    nInstructions = 1+fix(rand*(maxChromosomeLength-minChromosomeLength)/4);
    chromosome = zeros(1,minChromosomeLength + (4 * nInstructions));
    lengthRegisters = lengthVariableRegisters + lengthConstantRegisters;

    for j = 1:size(chromosome,2)
        modular = mod(j,4);
        switch modular
            % operator
            case 1
                chromosome(j) = fix(rand()*lengthOperators+1);
            % destination variable
            case 2
                chromosome(j) = fix(rand()*lengthVariableRegisters+1);
            % operand 1 and 2
            case {3,0} 
                chromosome(j) = fix(rand()*lengthRegisters+1);
        end

    end
    
    tmpIndividual = struct('Chromosome',chromosome);
    
    population = [population tmpIndividual];
end