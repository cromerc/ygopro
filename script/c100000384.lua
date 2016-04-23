--夕日の決闘場
function c100000384.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EVENT_PHASE_START+PHASE_BATTLE)
	e1:SetCountLimit(1)
	e1:SetCondition(c100000384.condition)
	e1:SetTarget(c100000384.target)
	e1:SetOperation(c100000384.activate)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCondition(c100000384.reccon)
	e2:SetTarget(c100000384.rectg)
	e2:SetOperation(c100000384.recop)
	c:RegisterEffect(e2)
	--cannot direct attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	c:RegisterEffect(e3)
	--activation
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)	
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EFFECT_CANNOT_ACTIVATE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(1,1)
	e4:SetValue(c100000384.aclimit)
	Duel.RegisterEffect(e4,tp)	
	--unaffectable
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e6:SetValue(1)
	c:RegisterEffect(e6)
	--cannot set
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_CANNOT_SSET)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e7:SetRange(LOCATION_SZONE)
	e7:SetTargetRange(1,1)
	e7:SetTarget(c100000384.aclimit2)
	c:RegisterEffect(e7)
	--
	local eb=Effect.CreateEffect(c)
	eb:SetType(EFFECT_TYPE_FIELD)
	eb:SetCode(EFFECT_CANNOT_TO_DECK)
	eb:SetRange(LOCATION_SZONE)
	eb:SetTargetRange(LOCATION_SZONE,0)
	eb:SetTarget(c100000384.tgn)
	c:RegisterEffect(eb)
	local ec=eb:Clone()
	ec:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(ec)
	local ed=eb:Clone()
	ed:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(ed)
	local ee=eb:Clone()
	ee:SetCode(EFFECT_CANNOT_REMOVE)
	c:RegisterEffect(ee)
end
function c100000384.condition(e,tp,eg,ep,ev,re,r,rp,chk)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>1 or Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>1
end
function c100000384.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return (Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil)
	or Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_MZONE,0,1,nil)) and Duel.GetTurnPlayer()==tp end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c100000384.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=nil
	if sg:FilterCount(Card.IsControler,nil,tp)>0 then
		if sg:FilterCount(Card.IsControler,nil,tp)>1 then
			tc=sg:FilterSelect(tp,Card.IsControler,1,1,nil,tp)		
		else
			tc=sg:Filter(Card.IsControler,nil,tp)
		end
		sg:RemoveCard(tc:GetFirst())
	end
	if sg:FilterCount(Card.IsControler,nil,1-tp)>0 then
		if sg:FilterCount(Card.IsControler,nil,1-tp)>1 then
			tc=sg:FilterSelect(1-tp,Card.IsControler,1,1,nil,1-tp)
		else
			tc=sg:Filter(Card.IsControler,nil,1-tp)
		end
		sg:RemoveCard(tc:GetFirst())
	end
	Duel.Destroy(sg,REASON_EFFECT)
end
function c100000384.reccon(e,tp,eg,ep,ev,re,r,rp)
	local rc=eg:GetFirst()
	return rc:IsRelateToBattle() and rc:IsFaceup()
end
function c100000384.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	local atk=Duel.GetAttacker():GetBaseAttack()
	if chk==0 then return atk>0 and ep==tp end
	local tc=eg:GetFirst():GetBattleTarget()
	if not tc:IsFaceup() then
		tc=eg:GetNext():GetBattleTarget()
	end
	Duel.SetTargetPlayer(tc:GetPreviousControler())
	Duel.SetTargetParam(300)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tc:GetPreviousControler(),300)
end
function c100000384.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c100000384.aclimit(e,re)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) and re:GetHandler():IsType(TYPE_FIELD)
end
function c100000384.aclimit2(e,c)
	return c:IsType(TYPE_FIELD)
end
function c100000384.tgn(e,c)
	return c==e:GetHandler()
end
