--The Phantom Knights of Wrong Magnet Ring
function c511009342.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511009342.condition)
	e1:SetCost(c511009342.cost)
	e1:SetTarget(c511009342.target)
	e1:SetOperation(c511009342.activate)
	c:RegisterEffect(e1)
end
function c511009342.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511009342.costfilter(c)
	return Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,c:GetCode()) and c:IsDiscardable()
end
function c511009342.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009342.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c511009342.costfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c511009342.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE) end
end
function c511009342.activate(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.NegateAttack() then return end
	Duel.BreakEffect()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e)
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,511009342,0x10db,0x21,1,0,0,RACE_WARRIOR,ATTRIBUTE_DARK)
	then return end
	Duel.BreakEffect()
	c:AddMonsterAttribute(TYPE_EFFECT)
	Duel.SpecialSummonStep(c,1,tp,tp,true,false,POS_FACEUP_ATTACK)
	c:AddMonsterAttributeComplete()
	
	--equip change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40884383,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511009342.eqtg)
	e1:SetOperation(c511009342.eqop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1,true)

	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(76925842,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c511009342.drcost)
	e2:SetCondition(c511009342.drcon)
	e2:SetTarget(c511009342.drtg)
	e2:SetOperation(c511009342.drop)
	c:RegisterEffect(e2)
	Duel.SpecialSummonComplete()
end

function c511009342.eqfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_EQUIP)
end
function c511009342.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) end
	if chk==0 then return Duel.IsExistingMatchingCard(c511009342.eqfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil)
	end

	
end
function c511009342.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() then
		local g=Duel.GetMatchingGroup(c511009342.eqfilter,tp,LOCATION_SZONE,LOCATION_SZONE,nil)
		local ec=g:GetFirst()
		while ec do
			Duel.Equip(tp,ec,c)
			ec=g:GetNext()
		end
		Duel.EquipComplete()
	end
	
end
function c511009342.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	local et=math.floor(e:GetHandler():GetEquipCount()/2)
	if et>0 then
		e:SetLabel(et)
	end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c511009342.drcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Debug.Message(c:GetEquipCount())
	 return e:GetHandler():GetEquipCount()>1
end

function c511009342.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,e:GetLabel()) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,e:GetLabel())
end
function c511009342.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
