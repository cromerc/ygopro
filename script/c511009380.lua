--SR fiendmagnet
function c511009380.initial_effect(c)
	--tograve
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(83236601,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511009380.condition)
	e1:SetTarget(c511009380.target)
	e1:SetOperation(c511009380.operation)
	c:RegisterEffect(e1)
	if not c511009380.global_check then
		c511009380.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetLabel(511009380)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetOperation(aux.sumreg)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge2:SetLabel(511009380)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511009380.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(511009380)>0
end
function c511009380.filter(c,e,tp,mc)
	local token=c
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SYNCHRO_MATERIAL)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	token:RegisterEffect(e1)
	local mg=Group.FromCards(token,mc)
	return not c:IsType(TYPE_TUNER)	and Duel.IsExistingMatchingCard(c511009380.scfilter,tp,LOCATION_EXTRA,0,1,nil,mg)
end
function c511009380.scfilter(c,mg)
	return c:IsSynchroSummonable(nil,mg)
end
function c511009380.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c511009380.filter(chkc,e,tp,e:GetHandler()) end
	if chk==0 then return Duel.IsExistingTarget(c511009380.filter,tp,0,LOCATION_MZONE,1,nil,e,tp,e:GetHandler()) end
		-- Debug.Message(Duel.IsExistingTarget(c511009380.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e,tp,e:GetHandler()))
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511009380.filter,tp,0,LOCATION_MZONE,1,1,nil,e,tp,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511009380.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	if not c:IsRelateToEffect(e) then return end
	local mg=Group.FromCards(c,tc)
	local g=Duel.GetMatchingGroup(c511009380.scfilter,tp,LOCATION_EXTRA,0,nil,mg)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SynchroSummon(tp,sg:GetFirst(),nil,mg)
	end
end
