--Fleur de Vertige
function c511000018.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c511000018.target)
	e1:SetOperation(c511000018.activate)
	c:RegisterEffect(e1)
end
function c511000018.filter(c,tp)
	return c:IsFaceup() and c:GetControler()~=tp
		and c:IsAbleToRemove()
end
function c511000018.cfilter(tc)
	return tc and tc:IsFaceup()
end
function c511000018.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511000018.filter,1,nil,tp) 
		and (c511000018.cfilter(Duel.GetFieldCard(tp,LOCATION_SZONE,5)) or c511000018.cfilter(Duel.GetFieldCard(1-tp,LOCATION_SZONE,5))) end
	Duel.SetTargetCard(eg)
	local g=eg:Filter(c511000018.filter,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c511000018.filter2(c,e,tp)
	return c:IsFaceup() and c:GetControler()~=tp
		and c:IsRelateToEffect(e) and c:IsAbleToRemove()
end
function c511000018.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000018.filter2,nil,e,tp)
	local tc=g:GetFirst()
	if not tc then return end
	if g:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		tc=g:Select(tp,1,1,nil):GetFirst()
	end
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end
