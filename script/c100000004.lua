--時械神 ラフィオン
function c100000004.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetRange(LOCATION_DECK)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000004,0))
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetCondition(c100000004.ntcon)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCondition(c100000004.dacon)
	e5:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	c:RegisterEffect(e5)
	--damage
	local e7=Effect.CreateEffect(c)
	e7:SetCategory(CATEGORY_DAMAGE)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e7:SetCode(EVENT_DAMAGE_STEP_END)
	e7:SetCondition(c100000004.damcon)
	e7:SetTarget(c100000004.damtg)
	e7:SetOperation(c100000004.damop)
	c:RegisterEffect(e7)
	--to deck
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(100000004,1))
	e8:SetCategory(CATEGORY_TODECK)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e8:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e8:SetProperty(EFFECT_FLAG_REPEAT)
	e8:SetCountLimit(1)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCondition(c100000004.tdcon)
	e8:SetTarget(c100000004.tdtg)
	e8:SetOperation(c100000004.tdop)
	c:RegisterEffect(e8)
end
function c100000004.ntcon(e,c)
	if c==nil then return true end
	return c:GetLevel()>4
		and Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c100000004.dacon(e)
	return e:GetHandler():IsAttackPos()
end
function c100000004.damcon(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	return bc
end
function c100000004.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local bc=e:GetHandler():GetBattleTarget()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(bc:GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,bc:GetAttack())
end
function c100000004.damop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Damage(p,bc:GetAttack(),REASON_EFFECT)
end
function c100000004.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c100000004.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c100000004.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and c:IsAbleToDeck() then
		Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
	end
end
