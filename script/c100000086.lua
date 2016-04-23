--ミラー・リゾネーター
function c100000086.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c100000086.spcon)	
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--lv
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000086,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(c100000086.thcon)
	e2:SetTarget(c100000086.thtg)
	e2:SetOperation(c100000086.thop)
	c:RegisterEffect(e2)
end
function c100000086.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c100000086.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000086.filter,c:GetControler(),0,LOCATION_MZONE,1,nil)
end
function c100000086.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+1
end
function c100000086.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c100000086.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000086.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c100000086.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c100000086.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc1=Duel.GetFirstTarget()
	local lv1=tc1:GetLevel()
	local lv2=e:GetHandler():GetLevel()
	if lv1==lv2 then return end
	if tc1:IsFaceup() and e:GetHandler():IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(lv1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e:GetHandler():RegisterEffect(e1)
	end
end