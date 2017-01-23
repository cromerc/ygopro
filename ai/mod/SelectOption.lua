--- OnSelectOption() ---
--
-- Called when AI has to choose an option
-- Example card(s): Elemental HERO Stratos
-- 
-- Parameters:
-- options = table of available options, this is one of the strings from the card database (str1, str2, str3, ..)
--
-- Return: index of the selected option
function OnSelectOption(options)
  local result = nil
  local d = DeckCheck()
  if d and d.Option then
    result = d.Option(options)
  end
  if result~=nil then return result end
  local optionfunctions={
  HeraldicOnSelectOption,QliphortOption,
  NekrozOption,DarkWorldOption,ConstellarOption,
  HarpieOption
  }
  for i=1,#optionfunctions do
    local func = optionfunctions[i]
    result = func(options)
    if result ~= nil then
      return result
    end
  end
  
  if GlobalDimensionalBarrier then
    local BarrierType={
    [TYPE_RITUAL]=1057,
    [TYPE_FUSION]=1056,
    [TYPE_SYNCHRO]=1063,
    [TYPE_XYZ]=1073,
    [TYPE_PENDULUM]=1074,}
    if GlobalDimensionalBarrier == true then
      local cards={}
      local highest=0
      result = nil
      for i,v in pairs(BarrierType) do
        cards[i]=CardsMatchingFilter(OppMon(),FilterType,i)*2
        + CardsMatchingFilter(SubGroup(OppGrave(),FilterType,TYPE_MONSTER),FilterType,i)
        + CardsMatchingFilter(SubGroup(OppExtra(),FilterPosition,POS_FACEUP),FilterType,i)
        if cards[i]>highest then
          highest=cards[i]
          result=v
        end
      end
      result=result or 1073
    else
      result = BarrierType[GlobalDimensionalBarrier]
    end
    GlobalDimensionalBarrier = nil
    for i,v in pairs(options) do
      if v==result then 
        return i
      end
    end
  end

  
  for i=1,#options do -- Ptolemy M7
    if options[i]==38495396*16+2 
    and HasPriorityTarget(OppMon(),false,nil,PtolemyFilter)
    then
      return i
    elseif options[i]==38495396*16+3 then
      return i
    end
  end
  
	result = 0
   ------------------------------------------------------    
   -- Return random result if it isn't specified below.
   ------------------------------------------------------   
	if GlobalActivatedCardID ~= 98045062 and GlobalActivatedCardID ~= 34086406 and  -- Enemy Controller, Lavalval Chain
       GlobalActivatedCardID ~= 12014404 and GlobalActivatedCardID ~= 70908596 then -- Gagaga Gunman, Constellar Kaust
       result = math.random(#options) 
	   return result
	end
	
	if GlobalActivatedCardID == 98045062 then -- Enemy Controller
	for i=1,#options do
      if options[i] == 1568720992 then
      result = i
       end
      end
    end  
    
	if GlobalActivatedCardID == 34086406 then -- Lavalval Chain
	for i=1,#options do
      if options[i] == 1 then
      result = i
       end
      end
    end  
	
	if GlobalActivatedCardID == 12014404 then -- Gagaga Gunman
	for i=1,#options do
      if options[i] == 1 then
      result = i
       end
      end
    end  
	 	
  end
