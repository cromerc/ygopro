--虚無
function c100000594.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000594,0))
	e2:SetType(EFFECT_TYPE_QUICK_F)
	e2:SetCode(EVENT_CHAIN_END)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c100000594.condition)
	e2:SetOperation(c100000594.operation)
	c:RegisterEffect(e2)
end
function c100000594.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000594.filter2,tp,LOCATION_ONFIELD,0,1,nil)
		and e:GetHandler():GetFlagEffect(100000594)==0
end
function c100000594.filter2(c)
	return c:IsFaceup() and c:IsCode(100000590)
end
function c100000594.filter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c100000594.filter3(c,seq1,seq2)
	return c:IsFacedown() and c:GetSequence()<seq1 and c:GetSequence()>seq2
end
function c100000594.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c100000594.filter,tp,LOCATION_SZONE,0,nil,100000595)
	local gd=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_SZONE,0,nil)
    e:GetHandler():RegisterFlagEffect(100000594,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	if g:GetCount()==0 then
		local sg=nil
		if e:GetHandler():IsHasEffect(100000703) 
		or Duel.GetMatchingGroupCount(c100000590.filter22,tp,LOCATION_MZONE,0,nil,60417395)>0 
		then sg=gd:Select(tp,1,1,nil)
		else sg=gd:RandomSelect(tp,1) end
		local tc=sg:GetFirst()
		if  tc:GetType()==TYPE_TRAP+TYPE_CONTINUOUS then
			Duel.ChangePosition(tc,POS_FACEUP)
		else
			Duel.ChangePosition(tc,POS_FACEUP)
			Duel.SendtoGrave(tc,REASON_EFFECT)	
		end
	else
		local fc=Duel.GetFirstMatchingCard(c100000594.filter,tp,LOCATION_SZONE,0,nil,100000595)
		local fseq=fc:GetSequence()
		local seq=e:GetHandler():GetSequence()
		if seq>fseq then
			local sqc=Duel.GetMatchingGroup(c100000594.filter3,tp,LOCATION_SZONE,0,nil,seq,fseq)
			local sqtc=sqc:GetFirst()
			while sqtc do 
				if  sqtc:GetType()==TYPE_TRAP+TYPE_CONTINUOUS then
					Duel.ChangePosition(sqtc,POS_FACEUP)
				else
					Duel.ChangePosition(sqtc,POS_FACEUP)
					Duel.SendtoGrave(sqtc,REASON_EFFECT)	
				end
				sqtc=sqc:GetNext()
			end	
		else
			local sqc=Duel.GetMatchingGroup(c100000594.filter3,tp,LOCATION_SZONE,0,nil,fseq,seq)
			local sqtc=sqc:GetFirst()
			while sqtc do 
				if  sqtc:GetType()==TYPE_TRAP+TYPE_CONTINUOUS then
					Duel.ChangePosition(sqtc,POS_FACEUP)
				else
					Duel.ChangePosition(sqtc,POS_FACEUP)
					Duel.SendtoGrave(sqtc,REASON_EFFECT)	
				end
				sqtc=sqc:GetNext()
			end	
		end
	end
end