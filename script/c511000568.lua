--Robotic Knight (DM)
--Scripted by edo9300
function c511000568.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(51100567,8))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,511000568)
	e1:SetCondition(c511000568.con)
	e1:SetCost(c511000568.cost)
	e1:SetTarget(c511000568.target)
	e1:SetOperation(c511000568.operation)
	c:RegisterEffect(e1)
	if not c511000568.global_check then
		c511000568.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c511000568.chk)
		Duel.RegisterEffect(ge1,0)
	end
end
c511000568.dm=true
function c511000568.chk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,300)
	Duel.CreateToken(1-tp,300)
end
function c511000568.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(300)>0
end
function c511000568.costfilter(c)
	return c:IsAbleToGraveAsCost() and c:IsRace(RACE_MACHINE)
end
function c511000568.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000568.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local cg=Duel.SelectMatchingCard(tp,c511000568.costfilter,tp,LOCATION_HAND,0,0,99,nil)
	Duel.SendtoGrave(cg,REASON_COST)
	e:SetLabel(cg:GetCount())
end
function c511000568.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=e:GetLabel()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ct*500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*500)
end
function c511000568.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end