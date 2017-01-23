--CX 冀望皇バリアン
function c511001363.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,3,nil,nil,5)
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(67926903,0))
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetCondition(c511001363.xyzcon)
	e0:SetOperation(c511001363.xyzop)
	e0:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e0)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c511001363.atkval)
	c:RegisterEffect(e1)
	--copy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(67926903,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c511001363.copycon)
	e2:SetTarget(c511001363.copytg)
	e2:SetOperation(c511001363.copyop)
	c:RegisterEffect(e2)
end
function c511001363.ovfilter(c)
	local code=c:GetCode()
	local class=_G["c"..code]
	if class==nil then return false end
	local no=class.xyz_number
	return c:IsFaceup() and no and no>=101 and no<=107 and c:IsSetCard(0x1048)
end
function c511001363.xyzcon(e,c,og)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(c511001363.ovfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if mg:GetCount()<=0 then return false end
	if mg:IsExists(Card.IsControler,1,nil,tp) then
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
	else
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	end
end
function c511001363.xyzop(e,tp,eg,ep,ev,re,r,rp,c,og)
	og=Group.CreateGroup()
	local mg=Duel.GetMatchingGroup(c511001363.ovfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	og:Merge(mg)
	local tc=mg:GetFirst()
	while tc do
		local ov=tc:GetOverlayGroup()
		if ov:GetCount()>0 then
			Duel.Overlay(c,ov)
			og:Merge(ov)
		end
		tc=mg:GetNext()
	end
	c:SetMaterial(og)
	Duel.Overlay(c,og)
end
function c511001363.atkval(e,c)
	return c:GetOverlayCount()*1000
end
function c511001363.copycon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511001363.filter(c,e)
	return c:IsCanBeEffectTarget(e) and e:GetHandler():GetFlagEffect(c:GetOriginalCode())==0
end
function c511001363.copytg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local a=c:CheckRemoveOverlayCard(tp,1,REASON_COST)
	local b=Duel.CheckLPCost(tp,800)
	local ov=c:GetOverlayGroup()
	if chkc then return false end
	if chk==0 then return (a or b) and ov:IsExists(c511001363.filter,1,nil,e) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=ov:FilterSelect(tp,c511001363.filter,1,1,nil,e)
	Duel.Hint(HINT_CARD,0,g:GetFirst():GetOriginalCode())
	e:SetProperty(0)
	Duel.SetTargetCard(g)
	e:SetProperty(EFFECT_FLAG_CARD_TARGET)
	local op=0
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(76922029,0))
	if a and b then
		op=Duel.SelectOption(tp,aux.Stringid(81330115,0),aux.Stringid(21454943,1))
	elseif a and not b then
		Duel.SelectOption(tp,aux.Stringid(81330115,0))
		op=0
	else
		Duel.SelectOption(tp,aux.Stringid(21454943,1))
		op=1
	end
	if op==0 then
		Duel.SendtoGrave(g,REASON_COST)	
	else
		Duel.PayLPCost(tp,800)
	end
	c:RegisterFlagEffect(g:GetFirst():GetOriginalCode(),RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c511001363.copyop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc then
		Duel.MajesticCopy(c,tc)
	end
end
