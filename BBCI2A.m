function [trl, event] = trialfun_motor(cfg)

%% the first part is common to all trial functions
% read the header (needed for the samping rate) and the events
hdr        = ft_read_header(cfg.dataset);
event      = hdr.orig.EVENT;
hdr.InChanSelect=hdr.orig.InChanSelect;
%% from here on it becomes specific to the experiment and the data format
% for the events of interest, find the sample numbers (these are integers)
% for the events of interest, find the trigger values (these are strings in the case of BrainVision)
EVsample   = [event.POS]';
EVvalue    = [event.TYP]';
EVduration = [event.DUR]';

% select the target stimuli
 Word = find(768<EVvalue&EVvalue<773);% for get the training epoch

% Word = find(EVvalue==783); % for test data


PreTrig   = 0;
PostTrig  = round(4 * hdr.Fs);

begsample = EVsample(Word) - PreTrig+1+250;
endsample = EVsample(Word) + PostTrig;

offset = -PreTrig*ones(size(endsample));



%% the last part is again common to all trial functions
% return the trl matrix (required) and the event structure (optional)
trl = [begsample'  endsample' offset' EVvalue(Word)'];

end % function
