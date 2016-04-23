--ＣＸ 機装魔人エンジェネラル
function c100000450.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.XyzFilterFunction(c,4),3)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c100000450.recon)
	e1:SetOperation(c100000450.reop)
	c:RegisterEffect(e1)
end
function c100000450.recon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
	 and e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,100000460)
end
function c100000450.reop(e,tp,eg,ep,ev,re,r,rp)	
	--damage
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c100000450.damcon)
	e2:SetLabel(0)
	e2:SetCost(c100000450.cost)
	e2:SetTarget(c100000450.damtg)
	e2:SetOperation(c100000450.damop)
	e:GetHandler():RegisterEffect(e2)
end
function c100000450.damcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c100000450.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetHandler():GetOverlayCount()
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,tc,REASON_COST) end
	e:SetLabel(tc)
	e:GetHandler():RemoveOverlayCard(tp,tc,tc,REASON_COST)
end
function c100000450.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=e:GetLabel()*500
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c100000450.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dam=e:GetLabel()*500
	Duel.Damage(p,dam,REASON_EFFECT)
end
