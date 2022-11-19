function [newIndividual1,newIndividual2] = TwoPointsCross(individual1, individual2)
    
   nGenes1 = size(individual1,2);
   nGenes2 = size(individual2,2);

   nInstructions1 = nGenes1/4;
   nInstructions2 = nGenes2/4;

   tempCrossoverPoint11 = (1 + fix(rand*(nInstructions1-1)))*4;
   tempCrossoverPoint12 = (1 + fix(rand*(nInstructions1-1)))*4;
   tempCrossoverPoint21 = (1 + fix(rand*(nInstructions2-1)))*4;
   tempCrossoverPoint22 = (1 + fix(rand*(nInstructions2-1)))*4;

   if tempCrossoverPoint11 < tempCrossoverPoint12
       crossoverPoint11 = tempCrossoverPoint11;
       crossoverPoint12 = tempCrossoverPoint12;
   else
       crossoverPoint11 = tempCrossoverPoint12;
       crossoverPoint12 = tempCrossoverPoint11;
   end
   if tempCrossoverPoint21 < tempCrossoverPoint22
       crossoverPoint21 = tempCrossoverPoint21;
       crossoverPoint22 = tempCrossoverPoint22;
   else
       crossoverPoint21 = tempCrossoverPoint22;
       crossoverPoint22 = tempCrossoverPoint21;
   end

   newInd11 = individual1(1:crossoverPoint11);
   newInd12 = individual2(crossoverPoint21+1:crossoverPoint22);
   newInd13 = individual1(crossoverPoint12+1:end);

   newInd21 = individual2(1:crossoverPoint21);
   newInd22 = individual1(crossoverPoint11+1:crossoverPoint12);
   newInd23 = individual2(crossoverPoint22+1:end);

   newIndividual1 = [newInd11 newInd12 newInd13];
   newIndividual2 = [newInd21 newInd22 newInd23];

end
