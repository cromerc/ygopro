--エクシーズ・シフト
function c108070081.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetLabel(0)
	e1:SetCost(c108070081.cost)
	e1:SetTarget(c108070081.target)
	e1:SetOperation(c108070081.activate)
	c:RegisterEffect(e1)
end
function c108070081.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c108070081.filter1,1,nil,e,tp) end
	local rg=Duel.SelectReleaseGroup(tp,c108070081.filter1,1,1,nil,e,tp)
	Duel.Release(rg,REASON_COST)
	e:SetLabelObject(rg:GetFirst())
end
function c108070081.filter1(c,e,tp)
	local rk=c:GetRank()
	return rk>0 and c:IsFaceup() and Duel.IsExistingMatchingCard(c108070081.filter2,tp,LOCATION_EXTRA,0,1,nil,rk,c:GetRace(),c:GetAttribute(),c:GetCode(),e,tp)
end
function c108070081.filter2(c,rk,rc,att,code,e,tp)
	return c:GetRank()==rk and c:IsRace(rc) and c:IsAttribute(att) and c:GetCode()~=code
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c108070081.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()==0 then return false end
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
			and Duel.IsExistingMatchingCard(c108070081.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c108070081.activate(e,tp,eg,ep,ev,re,r,rp)
	local rk=e:GetLabelObject():GetRank()
	local rc=e:GetLabelObject():GetRace()
	local att=e:GetLabelObject():GetAttribute()
	local code=e:GetLabelObject():GetCode()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c108070081.filter2,tp,LOCATION_EXTRA,0,1,1,nil,rk,rc,att,code,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)~=0 then
		e:GetHandler():CancelToGrave()
		Duel.Overlay(tc,Group.FromCards(e:GetHandler()))
		--to grave
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCountLimit(1)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e2:SetOperation(c108070081.tgop)
		tc:RegisterEffect(e2)
	end
end
function c108070081.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
end
