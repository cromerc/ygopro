--ヒロイック・ガード
function c100000222.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetCost(c100000222.cost)
	e1:SetCondition(c100000222.condition)
	e1:SetTarget(c100000222.target)
	e1:SetOperation(c100000222.activate)
	c:RegisterEffect(e1)
end
function c100000222.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x6f) end
	local sg=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0x6f)
	local tc=sg:GetFirst()
	local atk=tc:GetAttack()
	Duel.Release(tc,REASON_COST)
	e:SetLabel(atk)
end
function c100000222.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==ep
end
function c100000222.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,e:GetLabel())
end
function c100000222.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
