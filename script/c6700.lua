--Scripted by Eerie Code
--Aither the Heaven Monarch
function c6700.initial_effect(c)
	--summon with 1 tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6700,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c6700.otcon)
	e1:SetOperation(c6700.otop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_PROC)
	c:RegisterEffect(e2)
	--Special Summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(6700,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCondition(c6700.spcon)
	e3:SetTarget(c6700.sptg)
	e3:SetOperation(c6700.spop)
	c:RegisterEffect(e3)
	--Instant
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(6700,2))
	e4:SetCategory(CATEGORY_SUMMON)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetRange(LOCATION_HAND)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetHintTiming(0,TIMING_MAIN_END)
	e4:SetCondition(c6700.adcon)
	e4:SetCost(c6700.adcost)
	e4:SetTarget(c6700.adtg)
	e4:SetOperation(c6700.adop)
	e4:SetLabel(1)
	c:RegisterEffect(e4)
end

function c6700.otfilter(c)
	return bit.band(c:GetSummonType(),SUMMON_TYPE_ADVANCE)==SUMMON_TYPE_ADVANCE
end
function c6700.otcon(e,c)
	if c==nil then return true end
	local mg=Duel.GetMatchingGroup(c6700.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	return c:GetLevel()>6 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1
		and Duel.GetTributeCount(c,mg)>0
end
function c6700.otop(e,tp,eg,ep,ev,re,r,rp,c)
	local mg=Duel.GetMatchingGroup(c6700.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local sg=Duel.SelectTribute(tp,c,1,1,mg)
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
end

function c6700.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_ADVANCE
end
function c6700.spfil1(c)
	return c:IsSetCard(0xbe) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGraveAsCost()
end
function c6700.spfil2(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:GetAttack()>=2400 and c:GetDefence()==1000 and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SPECIAL,tp,false,false)
end
function c6700.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then 
		return Duel.GetMatchingGroup(c6700.spfil1,tp,LOCATION_HAND+LOCATION_DECK,0,nil):GetClassCount(Card.GetCode)>=2 and Duel.IsExistingMatchingCard(c6700.spfil2,tp,LOCATION_DECK,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	end
end
function c6700.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	local g1=Duel.GetMatchingGroup(c6700.spfil1,tp,LOCATION_HAND+LOCATION_DECK,0,nil)
	local cg=Group.CreateGroup()
	for i=1,2 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=g1:Select(tp,1,1,nil)
		g1:Remove(Card.IsCode,nil,sg:GetFirst():GetCode())
		cg:Merge(sg)
	end
	if Duel.SendtoGrave(cg,REASON_COST)>0 then
		local g2=Duel.SelectMatchingCard(tp,c6700.spfil2,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if g2:GetCount()>0 then 
			local tc=g2:GetFirst()
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e2:SetRange(LOCATION_MZONE)
			e2:SetCode(EVENT_PHASE+PHASE_END)
			e2:SetOperation(c6700.retop)
			e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			e2:SetCountLimit(1)
			tc:RegisterEffect(e2,true)
		end
	end
end
function c6700.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
end

function c6700.adcon(e,tp,eg,ep,ev,re,r,rp)
	local tn=Duel.GetTurnPlayer()
	local ph=Duel.GetCurrentPhase()
	return tn~=tp and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2)
end
function c6700.cfilter(c)
	return c:IsSetCard(0xbe) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToRemoveAsCost()
end
function c6700.adcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6700.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c6700.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c6700.adtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(6700)==0 and (c:IsSummonable(true,nil,1) or c:IsMSetable(true,nil,1)) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,c,1,0,0)
	c:RegisterFlagEffect(6700,RESET_CHAIN,0,1)
end
function c6700.adop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()~=1 then return end
	if c and c:IsRelateToEffect(e) then
		local s1=c:IsSummonable(true,nil,1)
		local s2=c:IsMSetable(true,nil,1)
		if (s1 and s2 and Duel.SelectPosition(tp,c,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENCE)==POS_FACEUP_ATTACK) or not s2 then
			Duel.Summon(tp,c,true,nil)
		else
			Duel.MSet(tp,c,true,nil)
		end
	end
end