--Advanced Crystal Beast Ruby Carbuncle
function c511001114.initial_effect(c)
	--Treated as "Crystal Beast Ruby Carbuncle"
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_ADD_CODE)
	e1:SetValue(32710364)
	c:RegisterEffect(e1)
	--Turn Crystals into Beasts
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(32710364,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetTarget(c511001114.crystalstobeaststg)
	e3:SetOperation(c511001114.crystalstobeastsop)
	c:RegisterEffect(e3)
	--Turn into Crystal
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(32710364,1))
	e4:SetCode(EFFECT_SEND_REPLACE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(c511001114.crystaltg)
	e4:SetOperation(c511001114.crystalop)
	c:RegisterEffect(e4)
	--selfdes
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(EFFECT_SELF_DESTROY)
	e5:SetRange(LOCATION_ONFIELD)
	e5:SetCondition(c511001114.descon)
	c:RegisterEffect(e5)
	--Special Summon self
	local e7=Effect.CreateEffect(c)
	e7:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetRange(LOCATION_SZONE)
	e7:SetTarget(c511001114.sptg)
	e7:SetOperation(c511001114.spop)
	c:RegisterEffect(e7)
end
function c511001114.descon(e)
	return not Duel.IsEnvironment(12644061)
end
function c511001114.crystaltg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetDestination()==LOCATION_GRAVE and c:IsReason(REASON_DESTROY) end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return false end
	return Duel.SelectEffectYesNo(tp,c)
end
function c511001114.crystalop(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	local e1=Effect.CreateEffect(c)
	e1:SetCode(EFFECT_CHANGE_TYPE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fc0000)
	e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
	c:RegisterEffect(e1)
	Duel.RaiseEvent(c,47408488,e,0,tp,0,0)
end
function c511001114.crystalstobeastfilter(c,e,sp)
	return c:IsFaceup() and c:IsSetCard(0x1034) and c:IsCanBeSpecialSummoned(e,0,sp,true,false)
end
function c511001114.crystalstobeaststg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001114.crystalstobeastfilter,tp,LOCATION_SZONE,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	local ct=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local gct=Duel.GetMatchingGroupCount(c511001114.crystalstobeastfilter,tp,LOCATION_SZONE,0,nil,e,tp)
	if ct>gct then
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,gct,tp,LOCATION_SZONE)
	else
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ct,tp,LOCATION_SZONE)
	end
end
function c511001114.crystalstobeastsop(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ct==0 then return end
	local g=Duel.GetMatchingGroup(c511001114.crystalstobeastfilter,tp,LOCATION_SZONE,0,nil,e,tp)
	local gc=g:GetCount()
	if gc==0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ct=1 end
	if gc<=ct then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,ct,ct,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511001114.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c511001114.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
