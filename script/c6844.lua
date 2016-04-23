--Scripted by Eerie Code
--Goyo Emperor
function c6844.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,c6844.ffilter,2,false)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6844,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c6844.spcon)
	e1:SetTarget(c6844.sptg)
	e1:SetOperation(c6844.spop)
	c:RegisterEffect(e1)
	--Take control
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(6844,1))
	e2:SetCategory(CATEGORY_CONTROL)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCost(c6844.concost)
	e2:SetTarget(c6844.contg)
	e2:SetOperation(c6844.conop)
	c:RegisterEffect(e2)
	--Return control
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(6844,2))
	e3:SetCategory(CATEGORY_CONTROL)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCondition(c6844.retcon)
	e3:SetTarget(c6844.rettg)
	e3:SetOperation(c6844.retop)
	c:RegisterEffect(e3)
end

function c6844.ffilter(c)
	return c:IsAttribute(ATTRIBUTE_EARTH) and c:IsRace(RACE_WARRIOR) and c:IsType(TYPE_SYNCHRO)
end

function c6844.spcon(e,tp,eg,ep,ev,re,r,rp)
	local bc=eg:GetFirst()
	local tc=bc:GetBattleTarget()
	return tc:IsLocation(LOCATION_GRAVE) and tc:IsReason(REASON_BATTLE) and tc:IsType(TYPE_MONSTER) and bc:IsRelateToBattle() and bc:IsControler(tp) and (bc==e:GetHandler() or bc:GetOwner()==1-tp)
end
function c6844.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=eg:GetFirst()
	local tc=bc:GetBattleTarget()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and tc:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tc,1,0,LOCATION_GRAVE)
end
function c6844.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c6844.confil(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsAttribute(ATTRIBUTE_EARTH) and c:IsRace(RACE_WARRIOR)
end
function c6844.concost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c6844.confil,1,e:GetHandler()) end
	local g=Duel.SelectReleaseGroup(tp,c6844.confil,1,1,e:GetHandler())
	Duel.Release(g,REASON_COST)
end
function c6844.confil2(c,tp)
	return c:IsFaceup() and c:IsControler(1-tp) and c:IsControlerCanBeChanged()
end
function c6844.contg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg and eg:IsExists(c6844.confil2,1,nil,tp) end
	local g=eg:Filter(Card.IsControlerCanBeChanged,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,g:GetCount(),0,0)
end
function c6844.conop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c6844.confil2,nil,tp)
	local loc=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if loc==0 then return end
	if g:GetCount()>loc then
		g=g:Select(tp,loc,loc,nil)
	end
	if g:GetCount()==0 then return end
	if e:GetHandler():IsRelateToEffect(e) then
		local tc=g:GetFirst()
		while tc do
			Duel.GetControl(tc,tp)
			tc=g:GetNext()
		end
	end
end

function c6844.retcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP)
end
function c6844.retfil(c)
	return c:GetControler()~=c:GetOwner()
end
function c6844.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6844.retfil,tp,LOCATION_MZONE,0,1,nil) end
end
function c6844.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	local tc=g:GetFirst()
	while tc do
		if not tc:IsImmuneToEffect(e) then
			tc:ResetEffect(EFFECT_SET_CONTROL,RESET_CODE)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_CONTROL)
			e1:SetValue(tc:GetOwner())
			e1:SetReset(RESET_EVENT+0xec0000)
			tc:RegisterEffect(e1)
		end
		tc=g:GetNext()
	end
end