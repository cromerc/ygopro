--Earthbound Disciple Geo Kraken
function c511002712.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c511002712.fusfilter,c511002712.fusfilter,true)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(48009503,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511002712.descon)
	e1:SetTarget(c511002712.destg)
	e1:SetOperation(c511002712.desop)
	c:RegisterEffect(e1)
end
function c511002712.fusfilter(c)
	return c:IsSetCard(0x21f) or c:IsSetCard(0x21) or c:IsCode(67105242) or c:IsCode(67987302)
end
function c511002712.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and eg:IsExists(Card.IsControler,1,nil,1-tp)
end
function c511002712.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,sg:GetCount()*800)
end
function c511002712.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	local ct=Duel.Destroy(sg,REASON_EFFECT)
	if ct>0 then
		Duel.Damage(1-tp,ct*800,REASON_EFFECT)
	end
end
