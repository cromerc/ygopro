--パワー・ゾーン
function c100000281.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EVENT_BATTLE_DESTROYED)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCondition(c100000281.reccon)
	e4:SetTarget(c100000281.rectg)
	e4:SetOperation(c100000281.recop)
	c:RegisterEffect(e4)
end
function c100000281.reccon(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return eg:GetCount()==1 and ec:IsReason(REASON_BATTLE)
end
function c100000281.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ec=eg:GetFirst()
	local atk=ec:GetBaseAttack()
	if chk==0 then return atk>0 end
	Duel.SetTargetPlayer(ec:GetPreviousControler())
	Duel.SetTargetParam(atk)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,ec:GetPreviousControler(),atk)
end
function c100000281.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
