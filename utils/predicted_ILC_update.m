function [G, G_APD] = predicted_ILC_update(C, G, err, ALFA, arm)
%PREDICTED_ILC_UPDATE Computes the predicted ILC update based on the
%current shoulder error and G values.
arguments (Input)
    C (1,4)
    G (1,3)
    err (1,2)
    ALFA (1,1) = 0.02
    arm (1,1) string = "LEFT"
end

if (arm=="RIGHT")
    sgn=-1;
elseif(arm=="LEFT")
    sgn=1;
end

err_J1=err(1);
err_J2=err(2);

% Muscle indices
MUSC_DELTOIDE_ANT = 1;
MUSC_DELTOIDE_MED = 2;
MUSC_DELTOIDE_POS = 3;

% Determine which muscle to update
if G(MUSC_DELTOIDE_ANT) ~= 0
    % Anterior deltoid being stimulated
    musc_update = "ANT";

elseif G(MUSC_DELTOIDE_POS) ~= 0
    % Posterior deltoid being stimulated
    musc_update = "POS";

else
    % Use error to define update

    if err_J1 <= 0
        musc_update = "ANT";
    else
        musc_update = "POS";
    end
end

% Update gains
if musc_update == "ANT"

    G_APD = G(MUSC_DELTOIDE_ANT);

    G_APD = G_APD + ...
        sgn * ALFA * (C(1)*err_J1 + C(2) * err_J2);

    G(MUSC_DELTOIDE_MED) = G(MUSC_DELTOIDE_MED) - ...
        ALFA * (C(3) * err_J1 + C(4)* err_J2);

else

    G_APD = -G(MUSC_DELTOIDE_POS);

    G_APD = G_APD + ...
        sgn * ALFA * (C(6)*err_J1 + C(5) * err_J2);

    G(MUSC_DELTOIDE_MED) = G(MUSC_DELTOIDE_MED) - ...
        ALFA * (C(3) * err_J1 + C(4)*err_J2);
end

% Assign anterior and posterior stimulation based on
% sign of combined gain
if G_APD > 0

    G(MUSC_DELTOIDE_ANT) = G_APD;
    G(MUSC_DELTOIDE_POS) = 0;

elseif G_APD < 0

    G(MUSC_DELTOIDE_ANT) = 0;
    G(MUSC_DELTOIDE_POS) = -G_APD;

else

    G(MUSC_DELTOIDE_ANT) = 0;
    G(MUSC_DELTOIDE_POS) = 0;

end




end