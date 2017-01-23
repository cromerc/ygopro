--Number 95: Galaxy Eyes Dark Matter Dragon
function c511000515.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,9,3)
	c:EnableReviveLimit()
	--banish
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000515,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c511000515.bantg)
	e1:SetOperation(c511000515.banop)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c511000515.val)
	c:RegisterEffect(e2)
	--chain attack
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000515,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DAMAGE_STEP_END)
	e3:SetCondition(c511000515.atcon)
	e3:SetCost(c511000515.atcost)
	e3:SetOperation(c511000515.atop)
	c:RegisterEffect(e3)
	--remove
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511000515,2))
	e4:SetCategory(CATEGORY_REMOVE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BATTLED)
	e4:SetTarget(c511000515.target)
	e4:SetOperation(c511000515.operation)
	c:RegisterEffect(e4)
	--battle indestructable
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e5:SetValue(c511000515.indes)
	c:RegisterEffect(e5)
	if not c511000515.global_check then
		c511000515.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511000515.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511000515.xyz_number=95
function c511000515.banfilter(c)
	return c:IsRace(RACE_DRAGON) and c:IsAbleToRemove()
end
function c511000515.banfilter2(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c511000515.bantg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000515.banfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,0)
end
function c511000515.banop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(1-tp,LOCATION_DECK,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511000515.banfilter,tp,LOCATION_DECK,0,1,ct,nil)
	if g:GetCount()>0 then
		if Duel.Remove(g,POS_FACEUP,REASON_EFFECT) then
			local sg=Duel.GetMatchingGroup(c511000515.banfilter2,tp,0,LOCATION_DECK,nil)
			if sg:GetCount()>=g:GetCount() then
				Duel.ConfirmCards(tp,sg)
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
				local ban=sg:Select(tp,1,g:GetCount(),nil)
				Duel.Remove(ban,POS_FACEUP,REASON_EFFECT)
			else
				local dg=Duel.GetFieldGroup(tp,0,LOCATION_DECK)
				Duel.ConfirmCards(tp,dg)
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
				local ban=sg:Select(tp,1,g:GetCount(),nil)
				Duel.Remove(ban,POS_FACEUP,REASON_EFFECT)
			end
		end
	end
end
function c511000515.val(e,c)
	local g=e:GetHandler():GetOverlayGroup()
	local atk=0
	local val=0
	local tc=g:GetFirst()
	while tc do
		if tc:IsType(TYPE_MONSTER) then
			atk=tc:GetAttack()
		else
			atk=0
		end
		val=val+atk
		tc=g:GetNext()
	end
	return val
end
function c511000515.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetAttacker()==c and c:IsChainAttackable()
end
function c511000515.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511000515.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end
function c511000515.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local a=Duel.GetAttacker()
	local t=Duel.GetAttackTarget()
	if chk==0 then
		return (t==c and a:IsAbleToRemove())
			or (a==c and t~=nil and t:IsAbleToRemove())
	end
	local g=Group.CreateGroup()
	if a:IsRelateToBattle() then g:AddCard(a) end
	if t~=nil and t:IsRelateToBattle() then g:AddCard(t) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c511000515.operation(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	local g=Group.FromCards(a,d)
	local rg=g:Filter(Card.IsRelateToBattle,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
end
function c511000515.indes(e,c)
	return not c:IsSetCard(0x48)
end
