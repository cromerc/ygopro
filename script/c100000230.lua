--除雪機関車ハッスル・ラッセル
function c100000230.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000230,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c100000230.spcon)
	e1:SetCost(c100000230.cost)
	e1:SetTarget(c100000230.sptg)
	e1:SetOperation(c100000230.spop)
	c:RegisterEffect(e1)
	--DAMAGE
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000230,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c100000230.thcon)
	e2:SetTarget(c100000230.thtg)
	e2:SetOperation(c100000230.thop)
	c:RegisterEffect(e2)
	e2:SetLabelObject(e1)
end
function c100000230.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c100000230.cfilter(c)
	return c:GetSequence()~=5 and c:IsDestructable()
end
function c100000230.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000230.cfilter,tp,LOCATION_SZONE,0,1,nil) end
	local sg=Duel.GetMatchingGroup(c100000230.cfilter,tp,LOCATION_SZONE,0,nil)
	e:SetLabel(sg:GetCount())
	Duel.Destroy(sg,REASON_COST)
end
function c100000230.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c100000230.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,1,tp,tp,true,false,POS_FACEUP) 
		c:CompleteProcedure()
	end
end
function c100000230.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+1
end
function c100000230.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=e:GetLabelObject():GetLabel()*200
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c100000230.thop(e,tp,eg,ep,ev,re,r,rp,c)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
