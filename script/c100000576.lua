--CNo.40　ギミック・パペット－デビルズ・ストリングス
function c100000576.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.XyzFilterFunctionF(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),9),3)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c100000576.recon)
	e1:SetOperation(c100000576.reop)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c100000576.indes)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(100000576,0))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c100000576.drtg)
	e3:SetOperation(c100000576.drop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetCondition(c100000576.drcon)
	c:RegisterEffect(e4)
end
c100000576.xyz_number=40
function c100000576.indes(e,c)
	return not c:IsSetCard(0x48)
end
function c100000576.drcon(e,tp,eg,ep,ev,re,r,rp)
	return re and e:GetHandler()==re:GetHandler()
end
function c100000576.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c100000576.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end

function c100000576.filter(c)
	return c:IsCode(75433814)
end
function c100000576.recon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
	 and e:GetHandler():GetOverlayGroup():IsExists(c100000576.filter,1,nil)
end
function c100000576.reop(e,tp,eg,ep,ev,re,r,rp)	
	--DESTROY
	local e4=Effect.CreateEffect(e:GetHandler())
	e4:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e4:SetDescription(aux.Stringid(100000576,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(c100000576.target)
	e4:SetCountLimit(1)
	e4:SetOperation(c100000576.operation)
	e4:SetReset(RESET_EVENT+0x1fe0000)
	e:GetHandler():RegisterEffect(e4)
	--counter
	local e5=Effect.CreateEffect(e:GetHandler())
	e5:SetDescription(aux.Stringid(100000576,1))
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetCountLimit(1)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetCost(c100000576.ctcost)
	e5:SetTarget(c100000576.cttg)
	e5:SetOperation(c100000576.ctop)
	e5:SetReset(RESET_EVENT+0x1fe0000)
	e:GetHandler():RegisterEffect(e5)
end
function c100000576.desfilter(c)
	return c:IsDestructable() and c:GetCounter(0x24)~=0
end
function c100000576.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000576.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c100000576.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c100000576.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c100000576.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local dam=g:GetSum(Card.GetBaseAttack)
	Duel.Destroy(g,REASON_EFFECT)
	Duel.Damage(1-tp,dam,REASON_EFFECT)
end
function c100000576.ctcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c100000576.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,g,1,0x24,1)
end
function c100000576.ctop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		tc:AddCounter(0x24,1)	
	end
end
