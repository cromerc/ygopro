--Clear Sacrifice
function c511000085.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000085.target)
	e1:SetOperation(c511000085.operation)
	c:RegisterEffect(e1)
end
function c511000085.filter(c)
	return c:GetLevel()>4 and (c:IsCode(97811903) or c:IsCode(100000160) or c:IsCode(100000161) or c:IsCode(100000162) or c:IsCode(100000163))
end
function c511000085.rfilter(c)
	return c:IsType(TYPE_MONSTER) and (c:IsCode(97811903) or c:IsCode(100000160) or c:IsCode(100000161) or c:IsCode(100000162) or c:IsCode(100000163)) and c:IsAbleToRemove()
end
function c511000085.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
	return Duel.IsExistingMatchingCard(c511000085.filter,tp,LOCATION_HAND,0,1,nil) 
		and Duel.IsExistingMatchingCard(c511000085.rfilter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_GRAVE)
end
function c511000085.operation(e,tp,eg,ep,ev,re,r,rp)
	local rg=Duel.GetMatchingGroup(c511000085.rfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511000085,1))
	local g=Duel.SelectMatchingCard(tp,c511000085.filter,tp,LOCATION_HAND,0,1,1,nil,rg)
	local tc=g:GetFirst()
	if tc then
		Duel.ConfirmCards(1-tp,tc)
		Duel.ShuffleHand(tp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local rg=Duel.SelectMatchingCard(tp,c511000085.rfilter,tp,LOCATION_GRAVE,0,2,2,nil)
		Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(511000085,0))
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SUMMON_PROC)
		e1:SetCondition(c511000085.ntcon)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c511000085.ntcon(e,c)
	if c==nil then return true end
	return c:GetLevel()>4 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
