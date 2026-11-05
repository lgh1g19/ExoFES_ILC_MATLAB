function [map] = exercise_map()
%EXERCISE_MAP returns cell array containing data about whether each muscle
%is activated for each phase of each mode
 map={
  % MODE_NONE
        {   % phases
            %[false,false,false,false,false],... % NOT_IN_GAME
            [false,false,false,false,false],... ... % WAIT_START
            [false,false,false,false,false],...... % REST_TO_START
            [false,false,false,false,false],... ...% START_TO_T1
            [false,false,false,false,false],... % REST
            [false,false,false,false,false],... % T1_TO_START
            [false,false,false,false,false],... % START_TO_REST
            [false,false,false,false,false],... % T1_TO_END
            [false,false,false,false,false],... % END_TO_START
            [false,false,false,false,false],... % FREE_MOVEMENT
            [false,false,false,false,false],... % START_TO_T2
            [false,false,false,false,false],... % T2_TO_START
            [false,false,false,false,false],... % T2_TO_END
            [false,false,false,false,false],... % START_TO_T3
            [false,false,false,false,false],... % T3_TO_START
            [false,false,false,false,false],... % T3_TO_END
            [false,false,false,false,false]  % REST_NO_SUC
        },... % MODE_RAZZO
    {  % phases
            %[false,false,false,false,false],... % NOT_IN_GAME
            [false,false,false,false,false],... % WAIT_START
            [false,false,false,false,false],... % REST_TO_START
            [false,true,false,false,false],...  % START_TO_T1 → solo DM
            [false,false,false,false,false],... % REST
            [false,false,false,false,false],... % T1_TO_START
            [false,false,false,false,false],... % START_TO_REST
            [false,false,false,false,false],... % T1_TO_END
            [false,false,false,false,false],... % END_TO_START
            [false,false,false,false,false],... % FREE_MOVEMENT
            [false,false,false,false,false],... % START_TO_T2
            [false,false,false,false,false],... % T2_TO_START
            [false,false,false,false,false],... % T2_TO_END
            [false,false,false,false,false],... % START_TO_T3
            [false,false,false,false,false],... % T3_TO_START
            [false,false,false,false,false],... % T3_TO_END
            [false,false,false,false,false]  % REST_NO_SUC
    },... % MODE_ASTRONAVE
    {  % phases
            %[false,false,false,false,false],... % NOT_IN_GAME
            [false,false,false,false,false],... % WAIT_START
            [false,false,false,false,false],... % REST_TO_START
            [true,true,false,true,false],...    % START_TO_T1 → DA, DM, TR
            [false,false,false,false,false],... % REST
            [false,false,false,false,false],... % T1_TO_START
            [false,false,false,false,false],... % START_TO_REST
            [false,true,false,false,true],...  % T1_TO_END → BC, DM
            [false,false,false,false,false],... % END_TO_START
            [false,false,false,false,false],... % FREE_MOVEMENT
            [true,true,false,true,false],...    % START_TO_T2 → DA, DM, TR
            [false,false,false,false,false],... % T2_TO_START
            [false,true,false,false,true],...    % T2_TO_END → BC, DM
            [false,true,true,true,false],...    % START_TO_T3 → DP, DM, TR
            [false,false,false,false,false],... % T3_TO_START
            [false,true,false,false,true],...    % T3_TO_END → BC, DM
            [false,false,false,false,false]  % REST_NO_SUC

    },... % MODE_PLANET
    {  % phases
            %[false,false,false,false,false],... % NOT_IN_GAME
            [false,false,false,false,false],... % WAIT_START
            [false,false,false,false,false],... % REST_TO_START
            [true,true,false,true,false],... % START_TO_T1
            [false,false,false,false,false],... % REST
            [false,false,false,false,true],... % T1_TO_START
            [false,false,false,false,false],... % START_TO_REST
            [false,false,false,false,false],... % T1_TO_END
            [false,false,false,false,false],... % END_TO_START
            [false,false,false,false,false],... % FREE_MOVEMENT
            [true,true,false,true,false],... % START_TO_T2
            [false,false,false,false,true],... % T2_TO_START
            [false,false,false,false,false],... % T2_TO_END
            [false,true,true,true,false],... % START_TO_T3
            [false,false,false,false,true],... % T3_TO_START
            [false,false,false,false,false],... % T3_TO_END
            [false,false,false,false,false]  % REST_NO_SUC
    },...
    { % MODE_ROVER
          % phases
            %[false,false,false,false,false],... % NOT_IN_GAME
            [false,false,false,false,false],... % WAIT_START
            [false,false,false,false,false],... % REST_TO_START
            [false,false,false,false,false],... % START_TO_T1
            [false,false,false,false,false],... % REST
            [false,false,false,false,false],... % T1_TO_START
            [false,false,false,false,false],... % START_TO_REST
            [false,false,false,false,false],... % T1_TO_END
            [false,false,false,false,false],... % END_TO_START
            [false,false,false,false,false],... % FREE_MOVEMENT
            [false,false,false,false,false],... % START_TO_T2
            [false,false,false,false,false],... % T2_TO_START
            [false,false,false,false,false],... % T2_TO_END
            [false,false,false,false,false],... % START_TO_T3
            [false,false,false,false,false],... % T3_TO_START
            [false,false,false,false,false],... % T3_TO_END
            [false,false,false,false,false]  % REST_NO_SUC
     
    }
};

end