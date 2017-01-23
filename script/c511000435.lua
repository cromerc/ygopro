--Golden Castle of Stromberg
function c511000435.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--maintain
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetOperation(c511000435.mtop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_REPEAT)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511000435.condition)
	e3:SetTarget(c511000435.target)
	e3:SetOperation(c511000435.operation)
	c:RegisterEffect(e3)
	--Cannot Normal Summon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EFFECT_CANNOT_SUMMON)
	e4:SetTargetRange(1,0)
	c:RegisterEffect(e4)
	--Opponent's monsters must attack
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_MUST_ATTACK)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e5)
	--Destroy monsters
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_DESTROY)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCode(EVENT_ATTACK_ANNOUNCE)
	e6:SetCondition(c511000435.atkcon)
	e6:SetTarget(c511000435.atktg)
	e6:SetOperation(c511000435.atkop)
	c:RegisterEffect(e6)
	--indes
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_SZONE)
	e7:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e7:SetValue(c511000435.indval)
	c:RegisterEffect(e7)
	--Cannot End
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD)
	e8:SetCode(EFFECT_CANNOT_EP)
	e8:SetRange(LOCATION_SZONE)
	e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e8:SetTargetRange(0,1)
	e8:SetCondition(c511000435.batcon)
	c:RegisterEffect(e8)
end
function c511000435.costfilter(c)
	return c:IsAbleToGrave()
end
function c511000435.mtop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	local g2=Duel.GetFieldGroupCount(1-tp,LOCATION_DECK,0)
	if tp==Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)~=0 and Duel.SelectYesNo(tp,aux.Stringid(511000435,0)) then
		local gc=Duel.GetMatchingGroup(c511000435.costfilter,tp,LOCATION_DECK,0,nil):RandomSelect(tp,math.floor(g1/2))
		Duel.SendtoGrave(gc,REASON_COST)
	elseif tp~=Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(1-tp,LOCATION_DECK,0)~=0 then
		local gc=Duel.GetMatchingGroup(c511000435.costfilter,1-tp,LOCATION_DECK,0,nil):RandomSelect(1-tp,math.floor(g2/2))
		Duel.SendtoGrave(gc,REASON_COST)
	else
		Duel.Destroy(e:GetHandler(),REASON_RULE)
	end
end
function c511000435.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp 
	and Duel.GetCurrentPhase()~=PHASE_DRAW 
	and Duel.GetCurrentPhase()~=PHASE_STANDBY
	and Duel.GetCurrentPhase()~=PHASE_BATTLE
	and Duel.GetCurrentPhase()~=PHASE_MAIN2
	and Duel.GetCurrentPhase()~=PHASE_END
end
function c511000435.filter(c,e,tp)
	return c:GetLevel()<=4 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000435.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_DECK) and c511000435.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsExistingTarget(c511000435.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
end
function c511000435.operation(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local g=Duel.GetMatchingGroup(c511000435.filter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g2=g:RandomSelect(tp,1):GetFirst()
		if Duel.SpecialSummon(g2,0,tp,tp,false,false,POS_FACEUP_ATTACK)==0 then return end
		c:SetCardTarget(g2)
		--Must Attack
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
	    e2:SetCode(EFFECT_MUST_ATTACK)
		g2:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD)
		e3:SetCode(EFFECT_CANNOT_EP)
		e3:SetRange(LOCATION_MZONE)
		e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e3:SetTargetRange(1,0)
		e3:SetCondition(c511000435.becon)
		g2:RegisterEffect(e3)
		Duel.SpecialSummonComplete()
		end	
	end
function c511000435.becon(e)
	return e:GetHandler():IsAttackable()
end
function c511000435.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511000435.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsDestructable() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
	local dam=tg:GetAttack()
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511000435.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsAttackable() and not tc:IsStatus(STATUS_ATTACK_CANCELED) then
		Duel.Destroy(tc,REASON_EFFECT)
		Duel.Damage(1-tp,tc:GetAttack()/2,REASON_EFFECT)
	end
end
function c511000435.indval(e,re)
	return re:GetOwner():IsType(TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP)
end
function c511000435.batfilter(c)
	return c:IsAttackable()
end
function c511000435.batcon(e)
	return Duel.IsExistingMatchingCard(c511000435.batfilter,tp,0,LOCATION_MZONE,1,nil)
end
