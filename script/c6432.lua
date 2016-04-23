--Scripted by Eerie Code
--PSYFrame Gear Delta
function c6432.initial_effect(c)
	c:SetStatus(STATUS_UNSUMMONABLE_CARD,true)
	--cannot pendulum summon
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(c6432.splimit)
	c:RegisterEffect(e0)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6432,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c6432.condition)
	e1:SetTarget(c6432.target)
	e1:SetOperation(c6432.operation)
	c:RegisterEffect(e1)
end

function c6432.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_PENDULUM)~=SUMMON_TYPE_PENDULUM
end

function c6432.egfil(c,tp)
	return c:GetSummonPlayer()==tp
end
function c6432.condition(e,tp,eg,ep,ev,re,r,rp)
	--local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return rp~=tp and re:IsActiveType(TYPE_SPELL) and Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_MZONE,0,nil)==0
end
function c6432.filter(c,e,tp)
	return c:IsCode(6428) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c6432.filter2(c)
	return c:IsSetCard(0xd3) and c:IsAbleToHand()
end
function c6432.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.IsExistingMatchingCard(c6432.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c6432.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c6432.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		local sg=Group.FromCards(e:GetHandler(),tc)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		sg:KeepAlive()
		tc:RegisterFlagEffect(6432,RESET_EVENT+0x1fe0000,0,1)
		e:GetHandler():RegisterFlagEffect(6432,RESET_EVENT+0x1fe0000,0,1)
		local de=Effect.CreateEffect(e:GetHandler())
		de:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		de:SetCode(EVENT_PHASE+PHASE_END)
		de:SetCountLimit(1)
		de:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		de:SetLabel(0)
		de:SetLabelObject(sg)
		de:SetCondition(c6432.descon)
		de:SetOperation(c6432.desop)
		Duel.RegisterEffect(de,tp)
		if Duel.GetOperatedGroup():FilterCount(Card.IsLocation,nil,LOCATION_MZONE)==2 then
			Duel.NegateActivation(ev)
			if re:GetHandler():IsRelateToEffect(re) then
				Duel.Destroy(eg,REASON_EFFECT)
			end
		end  
	end
end

function c6432.descon(e,tp,eg,ep,ev,re,r,rp)
	local tg=e:GetLabelObject()
	local b=false
	local tc=tg:GetFirst()
	while tc and not b do
	  b=tc:GetFlagEffect(6432)==0
		tc=tg:GetNext()
	end
	return Duel.GetTurnCount()~=e:GetLabel() and not b
end
function c6432.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end