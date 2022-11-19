clear all;
clc;
%% variables
constantRegisters = [1 2 3 4 pi -2];
operators = [1 2 3 4]; % [+,-,*,/]
lengthVariableRegisters = 4;
lengthConstantRegisters = size(constantRegisters,2);
lengthOperators = size(operators,2);

% population
nGenerations = 10000;
populationSize = 100; 
minChromosomeLength = 4 * 10;
maxChromosomeLength = 4 * 25;

population = InitializePopulation(populationSize,maxChromosomeLength,minChromosomeLength, ...
    lengthConstantRegisters,lengthVariableRegisters, ...
    lengthOperators);

% GA
tournamentSize = 4;
tournamentProbability = 0.75;
crossoverProbability = 0.5;
mutationProbability = 0.02;
minMutationProbability = 0.001;
penaltyFactor = 0.7;
mDecay = 0.999;

maximumFitness = 0;
meanFitnessArray = [];
maxFitnessArray =[];
generationArray = [];
generation = 1;

while maximumFitness < 25
    fitnessList = zeros(1,populationSize);
    for i = 1:populationSize
        chromosome = population(i).Chromosome;
        fitnessList(i) = EvaluateIndividual(chromosome,minChromosomeLength,maxChromosomeLength,lengthVariableRegisters,constantRegisters,penaltyFactor);
        if fitnessList(i) > maximumFitness 
            maximumFitness = fitnessList(i);
            iBestIndividual = i;
            bestChromosome = chromosome;
            sprintf('Generation : %i Fitness: %0.3f i: %i Pmu:%0.4f',generation,maximumFitness,iBestIndividual,mutationProbability)
        end
        
    end

    generationArray = [generationArray generation];
    meanFitnessArray = [meanFitnessArray mean(fitnessList)];
    maxFitnessArray = [maxFitnessArray max(fitnessList)];

    temporaryPopulation = population;
    for i = 1:2:populationSize
        i1 = TournamentSelect(fitnessList,tournamentProbability,tournamentSize);
        i2 = TournamentSelect(fitnessList,tournamentProbability,tournamentSize);
        r = rand;
        if (r < crossoverProbability)
            individual1 = population(i1).Chromosome;
            individual2 = population(i2).Chromosome;
            [newIndividual1,newIndividual2] = TwoPointsCross(individual1, individual2);
            temporaryPopulation(i).Chromosome = newIndividual1;
            temporaryPopulation(i+1).Chromosome = newIndividual2;
        else
            temporaryPopulation(i).Chromosome = population(i1).Chromosome;
            temporaryPopulation(i+1).Chromosome = population(i2).Chromosome;     
        end
    end

   temporaryPopulation(1).Chromosome = bestChromosome;
   for i = 2:populationSize
       tempIndividual = Mutate(temporaryPopulation(i).Chromosome,mutationProbability, ...
           lengthConstantRegisters,lengthVariableRegisters,lengthOperators);
       temporaryPopulation(i).Chromosome = tempIndividual;
   end
   
   % Try to varying mutation rate but the result is not good
%    if mutationProbability > minMutationProbability 
%        mutationProbability = mutationProbability * mDecay;
%    end

   population = temporaryPopulation;
   generation = generation + 1;
   if mod(generation,100) == 0
    sumSize = 0;
    for i = 1:populationSize
       sumSize = sumSize + size(population(i).Chromosome,2);
    end
    sprintf('Generation : %i Population size : %i Fitness : %0.3f',generation,sumSize,maximumFitness)
    plot(generationArray, meanFitnessArray, 'r--',generationArray, maxFitnessArray,'bo');
    legend("mean","max")
    xlabel('Generation')
    ylabel('Fitness Score')

    drawnow;
   end
end

sprintf('Generation : %i Fitness: %0.3f i: %i',generation,maximumFitness,iBestIndividual)
matlab.io.saveVariablesToScript('BestChromosome.m', 'bestChromosome')