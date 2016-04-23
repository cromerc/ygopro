--トゥーン·キングダム
function c500000090.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c500000090.rmtg)
	e1:SetOperation(c500000090.rmop)
	c:RegisterEffect(e1)
	--code
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CHANGE_CODE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetValue(15259703)
	c:RegisterEffect(e2)
	--Battle
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTarget(c500000090.destg)
	e3:SetValue(c500000090.value)
	c:RegisterEffect(e3)
end
function c500000090.rmtg(e,tp,eg,ep,ev,re,r,rp,chk) --発動コスト
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,5,tp,LOCATION_DECK)
end
function c500000090.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g1=Duel.GetDecktopGroup(tp,5)
	Duel.DisableShuffleCheck()
	Duel.Remove(g1,POS_FACEUP,REASON_EFFECT)
end

function c500000090.repfilter(c)
	return  c:IsAbleToGrave()
end
function c500000090.dfilter(c,tp)
	return c:IsControler(tp) and c:IsReason(REASON_BATTLE) and c:IsType(TYPE_TOON) 
end
function c500000090.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c500000090.dfilter,1,nil,tp) end
		local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_BATTLE) 
		 end
	if Duel.SelectYesNo(tp,aux.Stringid(500000090,0))then
		local g2=Duel.GetDecktopGroup(tp,1)
	Duel.DisableShuffleCheck()
	Duel.Remove(g2,POS_FACEUP,REASON_EFFECT)
		return true
	else return false end
end
function c500000090.value(e,c)
	return c:IsControler(e:GetHandlerPlayer()) and c:IsReason(REASON_BATTLE)
end

