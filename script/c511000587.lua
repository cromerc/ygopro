--Tarotray the Sibylla
function c511000587.initial_effect(c)
	c:EnableReviveLimit()
	--turn set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000587,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511000587.cost)
	e1:SetTarget(c511000587.target)
	e1:SetOperation(c511000587.operation)
	c:RegisterEffect(e1)
	--flip face-up
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000587,1))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511000587.con)
	e2:SetTarget(c511000587.tg)
	e2:SetOperation(c511000587.op)
	c:RegisterEffect(e2)
end
function c511000587.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetAttackAnnouncedCount()==0 end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1,true)
end
function c511000587.filter(c)
	return c:IsFaceup() and c:IsCanTurnSet() and c:IsType(TYPE_FLIP)
end
function c511000587.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000587.filter,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c511000587.filter,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c511000587.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511000587.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)
	end
end
function c511000587.con(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511000587.filter2(c)
	return c:IsFacedown() and c:IsDefensePos()
end
function c511000587.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000587.filter2,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c511000587.filter2,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c511000587.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511000587.filter2,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEUP_ATTACK)
	end
end
