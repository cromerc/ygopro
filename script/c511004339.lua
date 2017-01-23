--Decoy Baby
--scripted by andré
function c511004339.initial_effect(c)
	--place a monster from the opponent side
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511004339.tg)
	e1:SetOperation(c511004339.op)
	c:RegisterEffect(e1)
end
function c511004339.filter1(c,e,tp)
	return c:IsFaceup() and c:GetCounter(0x1107)~=0 and Duel.IsExistingMatchingCard(c511004339.filter2,tp,0,LOCATION_MZONE,1,nil,e,tp,c,c:GetRace())
end
function c511004339.filter2(c,e,tp,mc,rc)
	return c:GetType()==mc:GetType() and c:GetRace()==rc
end
function c511004339.tg(e,tp,eg,ev,ep,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(1-tp) and c511004339.filter1(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingMatchingCard(c511004339.filter1,tp,LOCATION_SZONE,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c511004339.op(e,tp,eg,ev,ep,re,r,rp,chk)
	local g1=Duel.SelectMatchingCard(tp,c511004339.filter1,tp,LOCATION_SZONE,0,1,1,nil,e,tp)
	local tc=g1:GetFirst()
	if tc then
		local g2=Duel.SelectMatchingCard(tp,c511004339.filter2,tp,0,LOCATION_MZONE,1,1,nil,e,tp,tc,tc:GetRace())
		local mtc=g2:GetFirst()
		if mtc and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
		   Duel.MoveToField(mtc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		   mtc:AddCounter(0x1107,1)
		end
	end
end