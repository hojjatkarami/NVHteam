function stop = pswplotbestf(optimValues,state)
%PSWPLOTBESTF Plot best function value.
%
%   STOP = PSWPLOTBESTF(OPTIMVALUES, STATE) plots OPTIMVALUES.BESTFVAL
%   against OPTIMVALUES.ITERATION. This function is called from
%   PARTICLESWARM with the following inputs:
%
%   OPTIMVALUES: Information after the current local solver call.
%          funccount: number of function evaluations
%              bestx: best solution found so far
%           bestfval: function value at bestx
%          iteration: iteration number
%           meanfval: average function value of swarm particles
%    stalliterations: number of iterations since improvement in the 
%                     objective function value stopped
%              swarm: the position of the swarm particles
%         swarmfvals: objective function value of swarm particles
% 
%   STATE: Current state in which plot function is called. 
%          Possible values are:
%             init: initialization state 
%             iter: iteration state 
%             done: final state
%
%   STOP: A boolean to stop the algorithm.
%
%   See also PARTICLESWARM

%   Copyright 2014 The MathWorks, Inc.

% Initialize stop boolean to false.

stop = false;
switch state
    case 'init'
        plotBest = plot(optimValues.iteration,optimValues.bestfval, '.b');
        set(plotBest,'Tag','psoplotbestf');
        xlabel('Iteration','interp','none');
        ylabel('Function value','interp','none')
        title(sprintf('Best Function Value: %g',optimValues.bestfval),'interp','none');
    case 'iter'
        plotBest = findobj(get(gca,'Children'),'Tag','psoplotbestf');
        newX = [get(plotBest,'Xdata') optimValues.iteration];
        newY = [get(plotBest,'Ydata') optimValues.bestfval];
        set(plotBest,'Xdata',newX, 'Ydata',newY);
        set(get(gca,'Title'),'String',sprintf('Best Function Value: %g',optimValues.bestfval));
        ylim([0 abs(optimValues.bestfval) *10+.1]);
    case 'done'
        % No clean up tasks required for this plot function.        
end    
