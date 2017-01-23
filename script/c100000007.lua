--時械神 ザフィオン
function c100000007.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetRange(LOCATION_DECK)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000007,0))
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetCondition(c100000007.ntcon)
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
	e5:SetCondition(c100000007.dacon)
	e5:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	c:RegisterEffect(e5)
	--to deck
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_TODECK)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e6:SetCountLimit(1)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCondition(c100000007.con)
	e6:SetTarget(c100000007.tg)
	e6:SetOperation(c100000007.op)
	c:RegisterEffect(e6)
	--to deck
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(100000007,1))
	e7:SetCategory(CATEGORY_TODECK)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e7:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e7:SetProperty(EFFECT_FLAG_REPEAT)
	e7:SetCountLimit(1)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCondition(c100000007.tdcon)
	e7:SetTarget(c100000007.tdtg)
	e7:SetOperation(c100000007.tdop)
	c:RegisterEffect(e7)
end
function c100000007.ntcon(e,c)
	if c==nil then return true end
	return c:GetLevel()>4
		and Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c100000007.dacon(e)
	return e:GetHandler():IsAttackPos()
end
function c100000007.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToDeck() 
end
function c100000007.con(e)
	return e:GetHandler():GetBattledGroupCount()>0 or e:GetHandler():GetAttackedCount()>0
end
function c100000007.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local sg=Duel.GetMatchingGroup(c100000007.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,sg,sg:GetCount(),0,0)
end
function c100000007.op(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c100000007.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SendtoDeck(sg,nil,2,REASON_EFFECT)
end
function c100000007.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c100000007.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c100000007.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and c:IsAbleToDeck() then
		Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
	end
end
