--RR lock Chain
function c511002191.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(2148918,0))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(c511002191.sptg)
	e2:SetOperation(c511002191.spop)
	c:RegisterEffect(e2)
end
function c511002191.filter(c,e)
	return c:IsFaceup() and c:IsSetCard(0xba)
end
function c511002191.tgfilter(c,e,tp)
	local atk=0
	local g=Duel.GetMatchingGroup(c511002191.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()<=0 then return false end
	local bc=g:GetFirst()
	while bc do
		atk=atk+bc:GetAttack()
		bc=g:GetNext()
	end
	return c:IsFaceup() and c:IsControler(1-tp) and c:GetAttack()>atk and c:IsCanBeEffectTarget(e)
end
function c511002191.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511002191.tgfilter,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=eg:FilterSelect(tp,c511002191.tgfilter,1,1,nil,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c511002191.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	end
end
